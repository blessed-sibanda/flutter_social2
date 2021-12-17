import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/services/users_service.dart';
import 'package:provider/provider.dart';
import 'package:chopper/chopper.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder(
            future: UsersService.create().getMyProfile(),
            builder: (context, AsyncSnapshot<Response<APIUser>> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                final user = snapshot.data!.body!;
                return UserAccountsDrawerHeader(
                  accountName: Text(
                    user.name,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  accountEmail: Text(
                    user.email!,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
                              ? NetworkImage(user.avatarUrl!) as ImageProvider
                              : const AssetImage('assets/images/user.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return const SizedBox(
                  height: 200.0,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
          const MenuListTileWidget(),
        ],
      ),
    );
  }
}

class MenuListTileWidget extends StatelessWidget {
  const MenuListTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.pop(context);
            appProvider.goToHome();
          },
        ),
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('People'),
          onTap: () {
            Navigator.pop(context);
            appProvider.goToPeople();
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Profile'),
          onTap: () {
            Navigator.pop(context);
            appProvider.goToProfile();
          },
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Log Out'),
          onTap: () {
            Navigator.pop(context);
            appProvider.logOut();
          },
        ),
      ],
    );
  }
}
