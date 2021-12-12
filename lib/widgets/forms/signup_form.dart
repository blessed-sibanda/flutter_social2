import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/auth.dart';
import 'package:flutter_social/providers/auth_screen_provider.dart';
import 'package:flutter_social/services/auth_service.dart';
import 'email_input_field.dart';
import 'form_wrapper.dart';
import 'text_input_field.dart';
import 'password_input_field.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String _error = '';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final _authService = AuthService.create();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formStateKey,
      child: FormWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sign Up'.toUpperCase(),
                style: Theme.of(context).textTheme.headline4),
            const Divider(),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
            TextInputField(label: 'Name', controller: _nameController),
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
                  child: const Text('Sign-in instead'),
                  onPressed: () {
                    Provider.of<AuthScreenProvider>(context, listen: false)
                        .goToSignIn();
                  },
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: _signUpUser,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signUpUser() async {
    if ((_formStateKey.currentState != null) &&
        (_formStateKey.currentState!.validate())) {
      final data = SignUpData(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      final response = await _authService.signUp(data);

      if (response.isSuccessful) {
        _showDialog('Sign Up Successful');
      } else {
        Map<String, dynamic> jsonBody = json.decode(response.bodyString);
        if (jsonBody.containsKey('errors')) {
          final emailErrors = jsonBody['errors']['email'] as List;
          setState(() => _error = 'Email ${emailErrors.first}');
        }
      }
    }
  }

  Future<void> _showDialog(value) async {
    var authScreenProvider =
        Provider.of<AuthScreenProvider>(context, listen: false);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return ChangeNotifierProvider<AuthScreenProvider>(
          create: (_) => authScreenProvider,
          child: AlertDialog(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value),
                const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            content: const Text(
              'We have sent you an email with account confirmation instructions.'
              ' Click on the link in the email to activate your account.',
            ),
            actions: [
              MaterialButton(
                color: Theme.of(context).primaryColor,
                elevation: 1.5,
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Proceed'),
                    SizedBox(width: 7.0),
                    Icon(Icons.arrow_forward),
                  ],
                ),
                onPressed: () {
                  authScreenProvider.goToSignIn();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
