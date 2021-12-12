import 'package:chopper/chopper.dart';
import 'package:flutter_social/models/user.dart';
import 'service_utils.dart';

part 'users_service.chopper.dart';

@ChopperApi(baseUrl: 'users/')
abstract class UsersService extends ChopperService {
  @Get(path: 'people')
  Future<Response<APIUserList>> getPeopleToFollow({@Query() int page = 1});

  @Get(path: '{id}')
  Future<Response<APIUser>> getUser(@Path() int id);

  @Get(path: 'me')
  Future<Response<APIUser>> getMyProfile();

  static UsersService create() {
    final client = ChopperClient(
      baseUrl: ServiceUtils.kBaseUrl,
      interceptors: [ServiceUtils.addAuthorization, HttpLoggingInterceptor()],
      errorConverter: const JsonConverter(),
      converter: const JsonConverter(),
      services: [
        _$UsersService(),
      ],
    );
    return _$UsersService(client);
  }
}
