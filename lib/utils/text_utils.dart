import 'package:flutter/material.dart';

class TextUtils {
  static cardHeaderText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 15.0, 0, 0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline6!.fontSize,
          color: Theme.of(context).primaryColor,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
