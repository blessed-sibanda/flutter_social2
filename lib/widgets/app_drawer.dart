import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/services/users_service.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersService = UsersService.create();
    return Consumer<AppProvider>(builder: (context, _, child) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder(
              future: usersService.getMyProfile(),
              builder: (context, AsyncSnapshot<Response<APIUser>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final user = snapshot.data!.body!;
                return UserAccountsDrawerHeader(
                  accountName: Text(user.name),
                  accountEmail: Text(user.email!),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: user.avatarUrl == null
                          ? const AssetImage('assets/images/user.png')
                          : NetworkImage(user.avatarUrl!) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            const MenuListTileWidget(),
          ],
        ),
      );
    });
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
