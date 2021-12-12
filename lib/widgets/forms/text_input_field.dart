import 'package:flutter/material.dart';
import 'form_validators.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final bool multiLine;
  final Function validator;
  const TextInputField({
    Key? key,
    required this.label,
    required TextEditingController controller,
    this.multiLine = false,
    this.validator = FormValidators.userNameField,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction:
          multiLine ? TextInputAction.newline : TextInputAction.next,
      keyboardType: multiLine ? TextInputType.multiline : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (value) => validator(value),
      maxLines: multiLine ? null : 1,
    );
  }
}
