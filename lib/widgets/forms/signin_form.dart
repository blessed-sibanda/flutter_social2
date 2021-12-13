import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/auth.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/providers/auth_screen_provider.dart';
import 'package:flutter_social/services/auth_service.dart';
import 'email_input_field.dart';
import 'form_wrapper.dart';
import 'password_input_field.dart';
import 'package:provider/provider.dart';
import 'email_action_dialog.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String _error = '';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService.create();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formStateKey,
            child: FormWrapper(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sign In'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const Divider(),
                  if (_error.isNotEmpty)
                    Text(
                      _error,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  EmailInputField(emailController: _emailController),
                  PasswordInputField(
                    label: 'Password',
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text('Sign-up instead'),
                        onPressed: () {
                          Provider.of<AuthScreenProvider>(context,
                                  listen: false)
                              .goToSignUp();
                        },
                      ),
                      const SizedBox(width: 20.0),
                      ElevatedButton(
                        child: const Text('Sign In'),
                        onPressed: _signIn,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: TextButton(
                    child: greyText('Resend email confirmation', context),
                    onPressed: () async {
                      await _showEmailActionDialog(
                        EmailAction.resendConfirmation,
                        context,
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    child: greyText('Forgot Password?', context),
                    onPressed: () async {
                      await _showEmailActionDialog(
                        EmailAction.resetPassword,
                        context,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text greyText(String text, BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.grey,
          ),
    );
  }

  void _signIn() async {
    if (_formStateKey.currentState!.validate()) {
      final data = SignInData(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Response<dynamic> response = await _authService.signIn(data);

      if (response.isSuccessful) {
        setState(() => _error = '');
        Provider.of<AppProvider>(context, listen: false).logIn();
      } else {
        setState(() => _error = response.error.toString());
      }
    }
  }

  Future<void> _showEmailActionDialog(
      EmailAction emailAction, BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return EmailActionDialog(
          emailAction: emailAction,
          emailController: _emailController,
        );
      },
    );
  }
}
