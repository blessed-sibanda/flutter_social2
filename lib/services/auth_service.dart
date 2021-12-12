import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/services/service_utils.dart';
import 'package:flutter_social/utils/app_cache.dart';

part "auth_service.chopper.dart";

@ChopperApi()
abstract class AuthService extends ChopperService {
  @Post(path: 'api/signup')
  Future<Response<APIUser>> signUp(
    @Field('user[name]') String name,
    @Field('user[email]') String email,
    @Field('user[password]') String password,
  );

  @Post(path: 'api/login')
  @FactoryConverter(response: authResponseConverter)
  Future<Response<APIUser>> signIn(
    @Field('user[email]') String email,
    @Field('user[password]') String password,
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
    String token = response.headers['authorization'] as String;
    _appCache.saveAuthToken(token);
    return response;
  }
}
