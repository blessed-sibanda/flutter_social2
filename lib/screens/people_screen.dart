import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/widgets/page_container.dart';
import 'package:flutter_social/widgets/who_to_follow.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  static get page => MaterialPage(
        child: PageContainer(const PeopleScreen()),
        name: AppPaths.userPath,
        key: const ValueKey(AppPaths.userPath),
      );

  @override
  Widget build(BuildContext context) {
    return const WhoToFollowCard();
  }
}
