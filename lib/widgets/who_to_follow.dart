import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/providers/people_provider.dart';
import 'package:flutter_social/services/users_service.dart';
import 'package:flutter_social/utils/screen_size.dart';
import 'package:flutter_social/widgets/follow_button.dart';
import 'package:flutter_social/utils/text_utils.dart';

import 'package:provider/provider.dart';
import 'improved_scrolling_wrapper.dart';

class WhoToFollowCard extends StatelessWidget {
  const WhoToFollowCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 450.0,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(ScreenSize.isLarge(context) ? 10.0 : 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextUtils.cardHeaderText(context, 'Who To Follow'),
                const SizedBox(height: 20.0),
                const Expanded(child: WhoToFollowList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WhoToFollowList extends StatefulWidget {
  const WhoToFollowList({Key? key}) : super(key: key);

  @override
  State<WhoToFollowList> createState() => _WhoToFollowListState();
}

class _WhoToFollowListState extends State<WhoToFollowList> {
  final _usersService = UsersService.create();
  final ScrollController _scrollController = ScrollController();
  bool _hasMore = false;
  int _currentPage = 1;
  late int _totalPages;
  late int _perPage;
  bool _loading = true;

  void _getUsers() async {
    final response = await _usersService.getPeopleToFollow(page: _currentPage);
    final data = response.body!;
    final provider = Provider.of<PeopleProvider>(context, listen: false);
    provider.addPeopleToFollow(data.users);
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
        final provider = Provider.of<PeopleProvider>(context, listen: false);
        if (provider.peopleToFollow.length <= (_perPage * (_currentPage + 1)) &&
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
      return _buildPeopleList();
    }
  }

  Widget _buildPeopleList() {
    return ImprovedScrollingWrapper(
      scrollController: _scrollController,
      child: Consumer<PeopleProvider>(builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.peopleToFollow.length,
          controller: _scrollController,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            APIUser user = provider.peopleToFollow[index];
            return InkWell(
              key: ValueKey(user.id),
              child: _buildUserTile(user),
              onTap: () => Provider.of<AppProvider>(context, listen: false)
                  .goToProfile(user.id),
            );
          },
        );
      }),
    );
  }

  Widget _buildUserTile(APIUser user) {
    final provider = Provider.of<PeopleProvider>(context, listen: false);
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
          beforeRequestCallback: () {
            provider.removePerson(user);
            if (provider.peopleToFollow.length < _perPage) {
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
