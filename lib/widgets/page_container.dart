import 'package:flutter/material.dart';
import 'package:flutter_social/utils/screen_size.dart';
import 'package:flutter_social/widgets/app_drawer.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  const PageContainer(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        child: FlutterSocialAppBar(),
        preferredSize: Size.fromHeight(56.0),
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
