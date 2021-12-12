// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AuthService extends AuthService {
  _$AuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthService;

  @override
  Future<Response<APIUser>> signUp(String name, String email, String password) {
    final $url = 'api/signup';
    final $body = <String, dynamic>{
      'user[name]': name,
      'user[email]': email,
      'user[password]': password
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<APIUser, APIUser>($request);
  }

  @override
  Future<Response<APIUser>> signIn(String email, String password) {
    final $url = 'api/login';
    final $body = <String, dynamic>{
      'user[email]': email,
      'user[password]': password
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<APIUser, APIUser>($request,
        responseConverter: AuthService.authResponseConverter);
  }
}
