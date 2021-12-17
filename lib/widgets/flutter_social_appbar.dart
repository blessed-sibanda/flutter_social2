import 'package:flutter/material.dart';
import 'package:flutter_social/utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:flutter_social/providers/app_provider.dart';

class FlutterSocialAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const FlutterSocialAppBar(this.scaffoldKey, {Key? key}) : super(key: key);

  @override
  State<FlutterSocialAppBar> createState() => _FlutterSocialAppBarState();
}

class _FlutterSocialAppBarState extends State<FlutterSocialAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Flutter Social'),
      automaticallyImplyLeading: false,
      elevation: 0.0,
      actions: [
        if (ScreenSize.isSmall(context))
          IconButton(onPressed: _openDrawer, icon: const Icon(Icons.menu)),
        if (!ScreenSize.isSmall(context))
          InkWell(
            child: _buildMenuButton(icon: Icons.home, label: 'Home'),
            onTap: _goToHomePage,
          ),
        if (ScreenSize.isMedium(context))
          InkWell(
            child: _buildMenuButton(label: 'People'),
            onTap: _goToPeople,
          ),
        if (!ScreenSize.isSmall(context))
          InkWell(
            child:
                _buildMenuButton(icon: Icons.account_circle, label: 'Profile'),
            onTap: _goToProfilePage,
          ),
        if (!ScreenSize.isSmall(context))
          InkWell(
            child: _buildMenuButton(icon: Icons.logout, label: 'Logout'),
            onTap: _logout,
          ),
      ],
    );
  }

  void _openDrawer() {
    widget.scaffoldKey.currentState!.openDrawer();
  }

  Widget _buildMenuButton({required String label, IconData? icon}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.isLarge(context) ? 30.0 : 15.0),
        child: (icon != null && ScreenSize.isLarge(context))
            ? Row(
                children: [
                  Icon(icon),
                  const SizedBox(width: 5.0),
                  Text(label),
                ],
              )
            : Text(label),
      ),
    );
  }

  void _goToPeople() {
    Provider.of<AppProvider>(context, listen: false).goToPeople();
  }

  void _logout() {
    Provider.of<AppProvider>(context, listen: false).logOut();
  }

  void _goToHomePage() {
    Provider.of<AppProvider>(context, listen: false).goToHome();
  }

  void _goToProfilePage() {
    Navigator.pop(context);
    Provider.of<AppProvider>(context, listen: false).goToProfile();
  }
}
