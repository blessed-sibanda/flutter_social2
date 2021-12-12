import 'package:flutter/material.dart';
import 'form_validators.dart';

class EmailInputField extends StatelessWidget {
  final String? helperText;
  const EmailInputField({
    Key? key,
    required TextEditingController emailController,
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
      validator: (value) => FormValidators.userEmailField(value),
    );
  }
}
