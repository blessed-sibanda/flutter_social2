import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/widgets/forms/edit_user_form.dart';
import 'package:flutter_social/widgets/page_container.dart';

class EditUserScreen extends StatelessWidget {
  const EditUserScreen({Key? key}) : super(key: key);

  static get page => MaterialPage(
        child: PageContainer(const EditUserScreen()),
        name: AppPaths.userEditPath,
        key: const ValueKey(AppPaths.userEditPath),
      );

  @override
  Widget build(BuildContext context) {
    return const EditUserForm();
  }
}
