// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$UsersService extends UsersService {
  _$UsersService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UsersService;

  @override
  Future<Response<APIUserList>> getPeopleToFollow({int page = 1}) {
    final $url = 'users/people.json';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<APIUserList, APIUserList>($request,
        responseConverter: UsersService.userListResponseConverter);
  }

  @override
  Future<Response<APIUserList>> getFollowers(int id, {int page = 1}) {
    final $url = 'users/${id}/followers.json';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<APIUserList, APIUserList>($request,
        responseConverter: UsersService.userListResponseConverter);
  }

  @override
  Future<Response<APIUserList>> getFollowing(int id, {int page = 1}) {
    final $url = 'users/${id}/following.json';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<APIUserList, APIUserList>($request,
        responseConverter: UsersService.userListResponseConverter);
  }

  @override
  Future<Response<APIUser>> getUser(int id) {
    final $url = 'users/${id}.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<APIUser, APIUser>($request,
        responseConverter: UsersService.userResponseConverter);
  }

  @override
  Future<Response<bool>> isFollowing(int id) {
    final $url = 'users/${id}/is_following.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<bool, bool>($request,
        responseConverter: UsersService.isFollowingResponseConverter);
  }

  @override
  Future<Response<dynamic>> followUser(int id) {
    final $url = 'users/${id}/follow';
    final $request = Request('PUT', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> unfollowUser(int id) {
    final $url = 'users/${id}/unfollow';
    final $request = Request('PUT', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
