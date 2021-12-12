import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/providers/auth_screen_provider.dart';
import 'package:flutter_social/widgets/forms/signin_form.dart';
import 'package:flutter_social/widgets/forms/signup_form.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: AuthScreen(),
        name: AppPaths.authPath,
        key: ValueKey(AppPaths.authPath),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthScreenProvider(),
      child: Consumer<AuthScreenProvider>(
        builder: (_, authScreenProvider, ___) {
          return Scaffold(
              body: authScreenProvider.currentPage == AuthScreenPage.signUp
                  ? const SignUpForm()
                  : const SignInForm());
        },
      ),
    );
  }
}
