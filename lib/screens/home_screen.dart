import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/utils/screen_size.dart';
import 'package:flutter_social/widgets/page_container.dart';
import 'package:flutter_social/widgets/who_to_follow.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static get page => MaterialPage(
        child: PageContainer(const HomeScreen()),
        name: AppPaths.homePath,
        key: const ValueKey(AppPaths.homePath),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text('Posts'),
          flex: 3,
        ),
        if (ScreenSize.isLarge(context))
          const Expanded(
            flex: 2,
            child: WhoToFollowCard(),
          )
      ],
    );
  }
}
