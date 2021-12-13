import 'dart:async';
import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:flutter_social/models/auth.dart';
import 'package:flutter_social/services/service_utils.dart';
import 'package:flutter_social/utils/app_cache.dart';
import 'package:http/http.dart' as http;

part "auth_service.chopper.dart";

@ChopperApi()
abstract class AuthService extends ChopperService {
  @Post(path: 'api/signup.json')
  Future<Response<Map<String, dynamic>>> signUp(
    @Field('user') SignUpData data,
  );

  @Put(path: 'api/signup.json')
  @multipart
  @FactoryConverter(request: updateUserRequestConverter)
  Future<Response<Map<String, dynamic>>> updateUser(
    @Field('user') UpdateUserData data,
    @Field('image_path') String? imagePath,
  );

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
      _appCache.saveUserId(jsonDecode(response.body)['id']);
    }
    return response;
  }

  static FutureOr<Request> authRequestConverter(Request request) {
    final headers = Map<String, String>.from(request.headers);
    headers[contentTypeKey] = jsonHeaders;
    headers['Accept'] = '*/*';
    return request.copyWith(headers: headers, body: jsonEncode(request.body));
  }

  static FutureOr<Request> updateUserRequestConverter(Request request) async {
    var newRequest =
        http.MultipartRequest(request.method, Uri.parse(request.url));
    final String? imagePath = newRequest.fields['image_path'];
    if (imagePath != null) {
      newRequest.files.add(
        await http.MultipartFile.fromPath('user[avatar_image]', imagePath),
      );
      newRequest.headers['Accept'] = '*/*';
    }
    return newRequest as Request;
  }
}
