import 'package:flutter_social/providers/current_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormWrapper extends StatelessWidget {
  final Widget child;
  const FormWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CurrentPasswordProvider(),
      child: Consumer<CurrentPasswordProvider>(builder: (_, __, ___) {
        return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 450.0,
                child: Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 20.0,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
