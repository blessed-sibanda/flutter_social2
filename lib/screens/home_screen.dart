import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/utils/screen_size.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';
import 'package:flutter_social/widgets/who_to_follow.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: HomeScreen(),
        name: AppPaths.homePath,
        // key: ValueKey(AppPaths.homePath),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        child: FlutterSocialAppBar(),
        preferredSize: Size.fromHeight(56.0),
      ),
      body: SafeArea(
        child: Padding(
          padding: ScreenSize.minPadding(context),
          child: Row(
            children: [
              const Expanded(
                child: Text('Posts'),
                flex: 2,
              ),
              if (ScreenSize.isLarge(context))
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(
                          ScreenSize.isLarge(context) ? 10.0 : 0.0),
                      child: const WhoToFollow(),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
