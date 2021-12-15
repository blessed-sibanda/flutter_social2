import 'package:flutter_social/widgets/page_container.dart';
import 'package:flutter_social/widgets/users_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/utils/text_utils.dart';
import 'package:flutter_social/widgets/user_info.dart';
import 'package:flutter_social/navigation/app_paths.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: PageContainer(UserProfileScreen()),
        name: AppPaths.userPath,
        key: ValueKey(AppPaths.userPath),
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultTabController(
        length: 3,
        child: Expanded(
          child: SizedBox(
            width: 550.0,
            height: MediaQuery.of(context).size.height,
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
    );
  }
}
