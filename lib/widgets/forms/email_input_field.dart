import 'package:flutter/material.dart';
import 'package:flutter_social/providers/email_provider.dart';
import 'package:provider/provider.dart';
import 'form_validators.dart';

class EmailInputField extends StatelessWidget {
  final bool emailValidation;
  final String? helperText;
  const EmailInputField({
    Key? key,
    required TextEditingController emailController,
    this.emailValidation = false,
    this.helperText,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: 'Email',
        helperText: helperText,
      ),
      validator: (value) => emailValidation &&
              Provider.of<EmailProvider>(context, listen: false).isInvalid()
          ? 'Email has already been taken'
          : FormValidators.userEmailField(value),
    );
  }
}
