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
  Future<Response<Map<String, dynamic>>> signUp(SignUpData data) {
    final $url = 'api/signup.json';
    final $body = <String, dynamic>{'user': data};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> signIn(SignInData data) {
    final $url = 'api/login';
    final $body = <String, dynamic>{'user': data};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request,
        requestConverter: AuthService.authRequestConverter,
        responseConverter: AuthService.authResponseConverter);
  }

  @override
  Future<Response<Map<String, dynamic>>> resendConfirmationEmail(
      EmailData data) {
    final $url = 'confirmation.json';
    final $body = <String, dynamic>{'user': data};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> requestPasswordReset(EmailData data) {
    final $url = 'password.json';
    final $body = <String, dynamic>{'user': data};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
