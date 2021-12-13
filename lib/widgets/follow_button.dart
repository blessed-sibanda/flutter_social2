import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/services/users_service.dart';

class FollowButton extends StatelessWidget {
  final _usersService = UsersService.create();

  final APIUser followed;
  final bool isFollowing;
  final Function afterFollowCallback;
  FollowButton({
    Key? key,
    required this.followed,
    required this.afterFollowCallback,
    this.isFollowing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 1.5,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        isFollowing
            ? await _usersService.unfollowUser(followed.id)
            : await _usersService.followUser(followed.id);

        afterFollowCallback.call();
        String innerText =
            isFollowing ? 'have unfollowed' : 'are now following';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You $innerText ${followed.name}'),
            duration: const Duration(milliseconds: 800),
          ),
        );
      },
      child: Text(isFollowing ? 'unfollow' : 'Follow'),
    );
  }
}
