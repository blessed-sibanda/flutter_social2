import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static get page => const MaterialPage(
        child: SplashScreen(),
        name: AppPaths.splashPath,
        key: ValueKey(AppPaths.splashPath),
      );

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).initializeApp();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Flutter Social',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 20.0),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
