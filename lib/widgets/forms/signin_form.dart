import 'dart:convert';
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
                        child: const Text('Sign-up'),
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
                    child: Text(
                      'Resend email confirmation',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    onPressed: () async {
                      await _showEmailActionDialog(
                        EmailAction.resendConfirmation,
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    onPressed: () async {
                      await _showEmailActionDialog(EmailAction.resetPassword);
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

  void _signIn() async {
    if (_formStateKey.currentState!.validate()) {
      final data = SignInData(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final response = await _authService.signIn(data);

      if (response.isSuccessful) {
        Provider.of<AppProvider>(context, listen: false).logIn();
      } else {
        Map<String, dynamic> jsonBody = json.decode(response.bodyString);
        if (jsonBody.containsKey('error')) {
          setState(() => _error = jsonBody['error']);
        }
      }
    }
  }

  Future<void> _showEmailActionDialog(EmailAction emailAction) async {
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
