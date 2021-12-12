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
    final $url = 'users/people';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<APIUserList, APIUserList>($request);
  }

  @override
  Future<Response<APIUser>> getUser(int id) {
    final $url = 'users/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<APIUser, APIUser>($request);
  }

  @override
  Future<Response<APIUser>> getMyProfile() {
    final $url = 'users/me';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<APIUser, APIUser>($request);
  }
}
