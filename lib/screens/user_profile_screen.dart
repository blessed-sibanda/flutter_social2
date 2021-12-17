import 'package:flutter_social/widgets/page_container.dart';
import 'package:flutter_social/widgets/users_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/utils/text_utils.dart';
import 'package:flutter_social/widgets/user_info.dart';
import 'package:flutter_social/navigation/app_paths.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: PageContainer(UserProfileScreen()),
        name: AppPaths.userPath,
        key: ValueKey(AppPaths.userPath),
      );

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tb;

  @override
  void initState() {
    super.initState();
    tb = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    tb.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 550.0,
      child: Card(
        child: NestedScrollView(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextUtils.cardHeaderText(context, 'Profile'),
                    const SizedBox(height: 15.0),
                    const UserInfo(),
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: [
              TabBar(
                controller: tb,
                labelColor: Colors.black54,
                tabs: const [
                  Tab(text: 'Posts'),
                  Tab(text: 'Following'),
                  Tab(text: 'Followers'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tb,
                  children: const [
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
    );
  }
}
