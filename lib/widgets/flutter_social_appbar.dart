import 'package:flutter/material.dart';
import 'package:flutter_social/utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:flutter_social/providers/app_provider.dart';

class MenuItems {
  static const people = 'People';
  static const myProfile = 'My Profile';
  static const signOut = 'Sign Out';

  static List<String> get smallScreen => [people, myProfile, signOut];
  static List<String> get bigScreen => [myProfile, signOut];
}

class FlutterSocialAppBar extends StatefulWidget {
  const FlutterSocialAppBar({Key? key}) : super(key: key);

  @override
  State<FlutterSocialAppBar> createState() => _FlutterSocialAppBarState();
}

class _FlutterSocialAppBarState extends State<FlutterSocialAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Flutter Social'),
      automaticallyImplyLeading: false,
      actions: [
        ScreenSize.isSmall(context)
            ? IconButton(onPressed: _goToHomePage, icon: const Icon(Icons.home))
            : InkWell(
                child: _buildMenuButton(icon: Icons.home, label: 'Home'),
                onTap: _goToHomePage,
              ),
        _buildDropdownMenu(),
      ],
    );
  }

  PopupMenuButton<String> _buildDropdownMenu() {
    var popUpMenuButton = ScreenSize.isSmall(context)
        ? PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: _performAction,
            itemBuilder: (_) => _buildMenuItems(MenuItems.smallScreen),
          )
        : PopupMenuButton<String>(
            child:
                _buildMenuButton(icon: Icons.account_circle, label: 'Account'),
            onSelected: _performAction,
            itemBuilder: (_) => _buildMenuItems(
              ScreenSize.isLarge(context)
                  ? MenuItems.bigScreen
                  : MenuItems.smallScreen,
            ),
          );

    return popUpMenuButton;
  }

  Center _buildMenuButton({required IconData icon, required String label}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 5.0),
            Text(label),
          ],
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems(List<String> menuItems) {
    return menuItems.map((item) {
      return PopupMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList();
  }

  void _performAction(valueSelected) {
    switch (valueSelected) {
      case MenuItems.signOut:
        Provider.of<AppProvider>(context, listen: false).logOut();
        break;
      case MenuItems.myProfile:
        Navigator.pop(context);
        Provider.of<AppProvider>(context, listen: false).goToProfile();
        break;
      case MenuItems.people:
        Provider.of<AppProvider>(context, listen: false).goToPeople();
        break;
      default:
    }
  }

  void _goToHomePage() {
    Provider.of<AppProvider>(context, listen: false).goToHome();
  }
}
