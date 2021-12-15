import 'dart:async';
import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:flutter_social/models/auth.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/services/service_utils.dart';
import 'package:flutter_social/utils/app_cache.dart';

part "auth_service.chopper.dart";

@ChopperApi()
abstract class AuthService extends ChopperService {
  @Post(path: 'api/signup.json')
  Future<Response<Map<String, dynamic>>> signUp(
    @Field('user') SignUpData data,
  );

  @Put(path: 'api/signup.json')
  @multipart
  Future<Response<Map<String, dynamic>>> updateUser(
      @Field('user') UpdateUserData data,
      [@PartFile('user[avatar_image]') List<int>? bytes]);

  @Post(path: 'api/login')
  @FactoryConverter(
    response: authResponseConverter,
    request: authRequestConverter,
  )
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
    if (token.isNotEmpty) {
      _appCache.saveAuthToken(token);
      APIUser user = APIUser.fromJson(jsonDecode(response.body));
      _appCache.saveCurrentUser(user);
    }
    return response;
  }

  static FutureOr<Request> authRequestConverter(Request request) {
    final headers = Map<String, String>.from(request.headers);
    headers[contentTypeKey] = jsonHeaders;
    headers['Accept'] = '*/*';
    return request.copyWith(headers: headers, body: jsonEncode(request.body));
  }
}
