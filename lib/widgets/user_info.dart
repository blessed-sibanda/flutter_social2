import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/providers/people_provider.dart';
import 'package:flutter_social/services/users_service.dart';
import 'package:flutter_social/widgets/follow_button.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  final int userId;
  const UserInfo(this.userId, {Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _usersService = UsersService.create();
  late APIUser _user;
  bool _isFollowing = false;

  void _setIsFollowing() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    final currentUserId = appProvider.currentUserId;
    if (currentUserId != widget.userId) {
      _usersService.isFollowing(widget.userId).then((response) {
        setState(() => _isFollowing = response.body!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _setIsFollowing();
  }

  @override
  Widget build(BuildContext context) {
    final userId =
        Provider.of<AppProvider>(context, listen: false).selectedUserId;
    return FutureBuilder(
      future: _usersService.getUser(userId),
      builder:
          (BuildContext context, AsyncSnapshot<Response<APIUser>> snapshot) {
        if (snapshot.hasData) {
          _user = snapshot.data!.body!;
          return _buildUserInfo(context);
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Column _buildUserInfo(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    int currentUserId = appProvider.currentUserId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(_user.name),
          subtitle: Text(_user.email!),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: _user.avatarUrl != null
                ? NetworkImage(_user.avatarUrl!)
                : const AssetImage('assets/images/user.png') as ImageProvider,
            foregroundColor: Colors.grey.shade200,
            backgroundColor: Colors.transparent,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_user.id == currentUserId)
                IconButton(
                  onPressed: () => appProvider.editUser(),
                  icon: const Icon(Icons.edit),
                ),
              if (_user.id == currentUserId)
                IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return _buildConfirmDeleteDialog(context);
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              if (_user.id != currentUserId)
                FollowButton(
                  followed: _user,
                  beforeRequestCallback: () {
                    setState(() => _isFollowing = !_isFollowing);
                    Provider.of<PeopleProvider>(context, listen: false)
                        .clearList();
                  },
                  isFollowing: _isFollowing,
                ),
            ],
          ),
        ),
        const Divider(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_user.about),
              Text('Joined: ${_user.joinedAt}'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildConfirmDeleteDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Delete Account'),
    content: const Text('Are you sure?'),
    actions: [
      MaterialButton(
        elevation: 1.0,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('No'),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
      ),
      MaterialButton(
        elevation: 1.0,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Yes'),
        color: Colors.red,
        textColor: Colors.white,
      ),
    ],
  );
}
