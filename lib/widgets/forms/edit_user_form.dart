import 'dart:convert';
import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/auth.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/providers/current_password_provider.dart';
import 'package:flutter_social/providers/email_provider.dart';
import 'package:flutter_social/services/users_service.dart';
import 'package:flutter_social/utils/text_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'email_input_field.dart';
import 'form_wrapper.dart';
import 'text_input_field.dart';
import 'password_input_field.dart';

class EditUserForm extends StatefulWidget {
  const EditUserForm({Key? key}) : super(key: key);

  @override
  _EditUserFormState createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _aboutController = TextEditingController();
  final _usersService = UsersService.create();
  final _currentPasswordProvider = CurrentPasswordProvider();
  final _emailProvider = EmailProvider();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  PickedFile? _image;
  String _error = '';
  bool _loading = true;
  late APIUser _user;

  void _loadUserData() async {
    final response = await _usersService.getMyProfile();
    final user = response.body!;
    setState(() {
      _nameController.text = user.name;
      _emailController.text = user.email!;
      _aboutController.text = user.about;
      _currentPasswordController.text = '';
      _user = user;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _aboutController.dispose();
    _currentPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formStateKey,
      child: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return FormWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextUtils.cardHeaderText(context, 'Edit Profile'),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildUserAvatarImage(_user),
                const SizedBox(height: 5.0),
                _buildUploadIconButtons(context)
              ],
            ),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
            TextInputField(label: 'Name', controller: _nameController),
            TextInputField(
              label: 'About',
              controller: _aboutController,
              multiLine: true,
              validator: (_) {},
            ),
            ChangeNotifierProvider(
              create: (_) => _emailProvider,
              child: Consumer<EmailProvider>(
                builder: (context, _, child) {
                  return EmailInputField(
                    emailController: _emailController,
                    emailValidation: true,
                  );
                },
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => _currentPasswordProvider,
              child: Consumer<CurrentPasswordProvider>(
                  builder: (context, _, child) {
                return PasswordInputField(
                  controller: _currentPasswordController,
                  currentPasswordValidation: true,
                  label: 'Current Password',
                );
              }),
            ),
            PasswordInputField(
              label: 'Password',
              controller: _passwordController,
              allowBlank: true,
            ),
            const SizedBox(height: 20.0),
            _buildFormActionButtons(context),
          ],
        ),
      );
    }
  }

  Row _buildFormActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () =>
              Provider.of<AppProvider>(context, listen: false).goToProfile(),
        ),
        const SizedBox(width: 20.0),
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) => _currentPasswordProvider),
            ChangeNotifierProvider(create: (context) => _emailProvider),
          ],
          child: Consumer2<CurrentPasswordProvider, EmailProvider>(
            builder: (context, _, __, snapshot) {
              return ElevatedButton(
                child: const Text('Update User'),
                onPressed: _updateUser,
              );
            },
          ),
        ),
      ],
    );
  }

  CircleAvatar _buildUserAvatarImage(APIUser user) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: _image == null
          ? user.avatarUrl == null
              ? const AssetImage('assets/images/user.png') as ImageProvider
              : NetworkImage(user.avatarUrl!)
          : (kIsWeb
              ? NetworkImage(_image!.path)
              : FileImage(File(_image!.path)) as ImageProvider),
      foregroundColor: Colors.grey.shade200,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildUploadIconButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!kIsWeb)
          IconButton(
              onPressed: () async {
                var image = await ImagePicker.platform
                    .pickImage(source: ImageSource.camera);
                setState(() => _image = image);
              },
              color: Theme.of(context).primaryColor,
              tooltip: 'Take Photo',
              icon: const Icon(Icons.camera_alt_outlined)),
        IconButton(
            onPressed: () async {
              var image = await ImagePicker.platform
                  .pickImage(source: ImageSource.gallery);
              setState(() => _image = image);
            },
            color: Theme.of(context).primaryColor,
            tooltip: 'Select Image',
            icon: const Icon(Icons.image)),
      ],
    );
  }

  String? get _imagePath {
    if (_image == null) return null;
    return File(_image!.path).absolute.path; // only works in non-web
  }

  void _updateUser() async {
    _currentPasswordProvider.validate();
    _emailProvider.validate();
    if ((_formStateKey.currentState != null) &&
        (_formStateKey.currentState!.validate())) {
      final data = UpdateUserData(
        name: _nameController.text,
        email: _emailController.text,
        currentPassword: _currentPasswordController.text,
        about: _aboutController.text,
        password:
            _passwordController.text.isEmpty ? null : _passwordController.text,
      );

      final response = await _usersService.updateUser(data, _imagePath);

      if (response.statusCode == 204) {
        Navigator.pop(context);
        Provider.of<AppProvider>(context, listen: false).goToProfile();
      } else {
        final errorString = await response.stream.bytesToString();
        Map<String, dynamic> errors = jsonDecode(errorString)['errors'];
        if (errors.containsKey('current_password') ||
            errors.containsKey('email')) {
          if (errors.containsKey('current_password')) {
            _currentPasswordProvider.invalidate();
          }
          if (errors.containsKey('email')) {
            _emailProvider.invalidate();
          }
        } else {
          setState(() => _error = errorString);
        }
      }
    }
  }
}
