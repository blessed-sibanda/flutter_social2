import 'package:flutter/material.dart';
import 'package:flutter_social/utils/screen_size.dart';
import 'package:flutter_social/widgets/app_drawer.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  PageContainer(this.child, {Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        child: FlutterSocialAppBar(_scaffoldKey),
        preferredSize: const Size.fromHeight(56.0),
      ),
      drawer: ScreenSize.isSmall(context) ? const AppDrawer() : null,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: ScreenSize.minPadding(context),
            child: child,
          ),
        ),
      ),
    );
  }
}
