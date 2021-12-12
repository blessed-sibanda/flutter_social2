import 'package:flutter_social/providers/current_password_provider.dart';
import 'package:flutter/material.dart';
import 'form_validators.dart';
import 'package:provider/provider.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final bool allowBlank;
  final String label;
  final bool currentPasswordValidation;

  const PasswordInputField({
    Key? key,
    required this.controller,
    required this.label,
    this.allowBlank = false,
    this.currentPasswordValidation = false,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscurePassword = true;

  void _toggleObscurePassword() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.label,
        suffix: GestureDetector(
          onTap: _toggleObscurePassword,
          child: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.black45,
          ),
        ),
        helperText: widget.allowBlank
            ? 'Leave this field blank if you do not want to change your ${widget.label}'
            : null,
        helperMaxLines: 2,
      ),
      validator: (value) => widget.currentPasswordValidation &&
              Provider.of<CurrentPasswordProvider>(context, listen: false)
                  .isInvalid
          ? '${widget.label} is invalid'
          : FormValidators.userPasswordField(
              value,
              allowBlank: widget.allowBlank,
              label: widget.label,
            ),
    );
  }
}
