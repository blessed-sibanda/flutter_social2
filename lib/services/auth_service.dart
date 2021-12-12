import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter_social/models/auth.dart';
import 'package:flutter_social/services/service_utils.dart';
import 'package:flutter_social/utils/app_cache.dart';

part "auth_service.chopper.dart";

@ChopperApi()
abstract class AuthService extends ChopperService {
  @Post(path: 'api/signup.json')
  Future<Response<Map<String, dynamic>>> signUp(
    @Field('user') SignUpData data,
  );

  @Post(path: 'api/login.json')
  @FactoryConverter(response: authResponseConverter)
  Future<Response<dynamic>> signIn(
    @Field('user') SignInData data,
  );

  @Post(path: 'confirmation.json')
  Future<Response<Map<String, dynamic>>> resendConfirmationEmail(
    @Field('user') EmailData data,
  );

  @Post(path: 'password.json')
  Future<Response<Map<String, dynamic>>> requestPasswordReset(
    @Field('user') EmailData data,
  );

  @Patch(path: 'password.json')
  Future<Response<Map<String, dynamic>>> resetPassword(
    @Field('user') ResetPasswordData data,
  );

  static AuthService create() {
    final client = ChopperClient(
      baseUrl: ServiceUtils.kBaseUrl,
      interceptors: [ServiceUtils.addAuthorization, HttpLoggingInterceptor()],
      errorConverter: const JsonConverter(),
      converter: const JsonConverter(),
      services: [
        _$AuthService(),
      ],
    );
    return _$AuthService(client);
  }

  static FutureOr<Response> authResponseConverter(Response response) {
    final _appCache = AppCache();
    String token = response.headers['authorization'] ?? '';
    if (token.isNotEmpty) _appCache.saveAuthToken(token);
    return response;
  }
}
