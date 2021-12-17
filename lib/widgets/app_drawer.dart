import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/services/users_service.dart';
import 'package:flutter_social/utils/app_cache.dart';
import 'package:provider/provider.dart';
import 'package:chopper/chopper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: const [
              UserImage(),
              Positioned(
                child: UserName(),
                bottom: 10.0,
                right: 10.0,
              ),
            ],
          ),
          const MenuListTileWidget(),
        ],
      ),
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UsersService.create().getMyProfile(),
      builder: (context, AsyncSnapshot<Response<APIUser>> snapshot) {
        final defaultImage = Image.asset('assets/images/user.png');

        if (snapshot.hasData) {
          final user = snapshot.data!.body!;
          if (user.avatarUrl != null) {
            return CachedNetworkImage(
              imageUrl: user.avatarUrl!,
              fit: BoxFit.cover,
              width: 304.0,
              height: 250.0,
            );
          } else {
            return defaultImage;
          }
        } else {
          return defaultImage;
        }
      },
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppCache().currentUser,
      builder: (context, AsyncSnapshot<APIUser> snapshot) {
        final user = snapshot.data!;
        return Text(
          user.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: Theme.of(context).textTheme.headline5!.fontSize,
          ),
        );
      },
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
