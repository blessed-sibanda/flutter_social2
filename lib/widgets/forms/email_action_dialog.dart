import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/auth.dart';
import 'package:flutter_social/providers/auth_screen_provider.dart';
import 'package:flutter_social/services/auth_service.dart';
import 'email_input_field.dart';

import 'package:provider/provider.dart';

class EmailActionDialog extends StatefulWidget {
  final TextEditingController emailController;
  final EmailAction emailAction;

  const EmailActionDialog({
    Key? key,
    required this.emailController,
    required this.emailAction,
  }) : super(key: key);

  @override
  _EmailActionDialogState createState() => _EmailActionDialogState();
}

class _EmailActionDialogState extends State<EmailActionDialog> {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  String _error = '';
  final _authService = AuthService.create();

  String _title = '';
  String _body = '';

  @override
  void initState() {
    super.initState();

    switch (widget.emailAction) {
      case EmailAction.resendConfirmation:
        _title = 'Resend Confirmation Email';
        _body = 'We have sent another account confirmation email '
            'to the provided email adress. Click on the link in the'
            ' email to activate your account';
        break;
      case EmailAction.resetPassword:
        _title = 'Request Password Reset';
        _body = 'An email with a reset password token has been sent '
            'to the provided email adress. Copy the reset-password-token '
            'and use it to reset your password';
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title, textAlign: TextAlign.center),
      content: Form(
        key: formStateKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_error.isNotEmpty)
              Text(
                _error,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            EmailInputField(
              emailController: widget.emailController,
              helperText: 'Enter your registered email address',
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          color: Colors.red,
          elevation: 1.5,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          elevation: 1.5,
          textColor: Colors.white,
          onPressed: () async {
            if (formStateKey.currentState!.validate()) {
              final data = EmailData(email: widget.emailController.text);
              final response =
                  widget.emailAction == EmailAction.resendConfirmation
                      ? await _authService.resendConfirmationEmail(data)
                      : await _authService.requestPasswordReset(data);

              if (response.isSuccessful) {
                Navigator.pop(context);
                _showSuccessDialog(_body);
              } else {
                Map<String, dynamic> jsonBody =
                    json.decode(response.bodyString);
                if (jsonBody.containsKey('errors')) {
                  final emailErrors = jsonBody['errors']['email'] as List;
                  setState(() => _error = 'Email ${emailErrors.first}');
                }
              }
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Future<void> _showSuccessDialog(String message) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return ChangeNotifierProvider(
          create: (_) => AuthScreenProvider(),
          child: Consumer<AuthScreenProvider>(builder: (context, _, __) {
            return AlertDialog(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Email Sent'),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
              content: Text(message),
              actions: [
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  elevation: 1.5,
                  textColor: Colors.white,
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                    switch (widget.emailAction) {
                      case EmailAction.resendConfirmation:
                        Provider.of<AuthScreenProvider>(context, listen: false)
                            .goToSignIn();
                        break;
                      case EmailAction.resetPassword:
                        // go to new-password page
                        break;
                      default:
                    }
                  },
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
