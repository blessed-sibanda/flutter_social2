import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/providers/people_provider.dart';
import 'package:flutter_social/services/users_service.dart';
import 'package:flutter_social/widgets/follow_button.dart';
import 'package:provider/provider.dart';

class WhoToFollow extends StatefulWidget {
  const WhoToFollow({Key? key}) : super(key: key);

  @override
  State<WhoToFollow> createState() => _WhoToFollowState();
}

class _WhoToFollowState extends State<WhoToFollow> {
  final _usersService = UsersService.create();
  final ScrollController _scrollController = ScrollController();
  bool _hasMore = false;
  int _currentPage = 1;
  late int _totalPages;
  late int _perPage;
  final _peopleProvider = PeopleProvider();
  bool _loading = true;

  void _getUsers() async {
    final response = await _usersService.getPeopleToFollow(page: _currentPage);
    final data = response.body!;
    _peopleProvider.addPeopleToFollow(data.users);
    setState(() => _loading = false);

    data.links.nextPage != null ? _hasMore = true : _hasMore = false;
    _perPage = data.meta.perPage;
    _totalPages = data.meta.totalPages;
  }

  @override
  void initState() {
    super.initState();

    _getUsers();

    _scrollController.addListener(() {
      final triggerFetchMore =
          0.85 * _scrollController.position.maxScrollExtent;
      if ((_scrollController.position.pixels > triggerFetchMore) && _hasMore) {
        if (_peopleProvider.peopleToFollow.length <=
                (_perPage * (_currentPage + 1)) &&
            _currentPage < _totalPages) {
          _currentPage++;
          _getUsers();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading == true) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ChangeNotifierProvider(
        create: (_) => _peopleProvider,
        child: Consumer<PeopleProvider>(
          builder: (context, peopleProvider, child) {
            return ListView.builder(
              itemCount: peopleProvider.peopleToFollow.length,
              controller: _scrollController,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                APIUser user = peopleProvider.peopleToFollow[index];
                return InkWell(
                  key: ValueKey(user.id),
                  child: _buildUserTile(context, user),
                  onTap: () => _goToUserProfile(user),
                );
              },
            );
          },
        ),
      );
    }
  }

  void _goToUserProfile(APIUser user) =>
      Provider.of<AppProvider>(context, listen: false)
          .goToProfile(userId: user.id);

  Widget _buildUserTile(BuildContext context, APIUser user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        title: Text(user.name),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: user.avatarUrl != null
              ? NetworkImage(user.avatarUrl!)
              : const AssetImage('assets/images/user.png') as ImageProvider,
          backgroundColor: Colors.transparent,
        ),
        trailing: FollowButton(
          followed: user,
          afterFollowCallback: () {
            _peopleProvider.removePerson(user);
            if (_peopleProvider.peopleToFollow.length < _perPage) {
              if (_hasMore) {
                _currentPage++;
                _getUsers();
              }
            }
          },
        ),
      ),
    );
  }
}
