import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';
import 'package:flutter_social/widgets/who_to_follow.dart';
import 'package:flutter_social/utils/screen_size.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: PeopleScreen(),
        name: AppPaths.userPath,
        key: ValueKey(AppPaths.userPath),
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
          child: const WhoToFollowCard(),
        ),
      ),
    );
  }
}
