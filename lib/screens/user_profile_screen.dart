import 'package:flutter_social/widgets/users_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/utils/screen_size.dart';
import 'package:flutter_social/utils/text_utils.dart';
import 'package:flutter_social/widgets/user_info.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: UserProfileScreen(),
        name: AppPaths.userPath,
        key: ValueKey(AppPaths.userPath),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const PreferredSize(
          child: FlutterSocialAppBar(),
          preferredSize: Size.fromHeight(56.0),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: ScreenSize.minPadding(context),
              child: SizedBox(
                width: 600,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextUtils.cardHeaderText(context, 'Profile'),
                      const SizedBox(height: 15.0),
                      const UserInfo(),
                      const SizedBox(height: 15.0),
                      const TabBar(
                        labelColor: Colors.black54,
                        tabs: [
                          Tab(text: 'Posts'),
                          Tab(text: 'Following'),
                          Tab(text: 'Followers'),
                        ],
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            Icon(Icons.directions_car),
                            UsersGrid(Relationship.following),
                            UsersGrid(Relationship.followers),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
