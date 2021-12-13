import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/services/users_service.dart';
import 'package:provider/provider.dart';

enum Relationship { followers, following }

class UsersGrid extends StatefulWidget {
  final Relationship relationship;

  const UsersGrid(this.relationship, {Key? key}) : super(key: key);

  @override
  _UsersGridState createState() => _UsersGridState();
}

class _UsersGridState extends State<UsersGrid> {
  final _usersService = UsersService.create();
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  late int _totalPages;
  final _users = <APIUser>[];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final triggerFetchMore =
          0.85 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > triggerFetchMore) {
        if (_currentPage < _totalPages) {
          setState(() => _currentPage++);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.relationship == Relationship.followers
          ? _usersService.getFollowers(page: _currentPage)
          : _usersService.getFollowing(page: _currentPage),
      builder: (BuildContext context,
          AsyncSnapshot<Response<APIUserList>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!.body!;

          _totalPages = data.meta.totalPages;
          _users.addAll(data.users);
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: _users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = _users[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Provider.of<AppProvider>(context, listen: false)
                        .goToProfile(userId: user.id);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: user.avatarUrl == null
                            ? const AssetImage('assets/user.png')
                                as ImageProvider
                            : NetworkImage(user.avatarUrl!),
                        foregroundColor: Colors.grey.shade200,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(height: 13.0),
                      Text(user.name, textAlign: TextAlign.center),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
