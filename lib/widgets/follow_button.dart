import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/services/users_service.dart';

class FollowButton extends StatelessWidget {
  final _usersService = UsersService.create();

  final APIUser followed;
  final bool isFollowing;

  // beforeRequestCallback - to update ui faster without waiting for the http request to complete
  final Function beforeRequestCallback;
  FollowButton({
    Key? key,
    required this.followed,
    required this.beforeRequestCallback,
    this.isFollowing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 1.5,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        String innerText =
            isFollowing ? 'have unfollowed' : 'are now following';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You $innerText ${followed.name}'),
            duration: const Duration(milliseconds: 800),
          ),
        );

        beforeRequestCallback.call();

        if (isFollowing) {
          await _usersService.unfollowUser(followed.id);
        } else {
          await _usersService.followUser(followed.id);
        }
      },
      child: Text(isFollowing ? 'unfollow' : 'Follow'),
    );
  }
}
