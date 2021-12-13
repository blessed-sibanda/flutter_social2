import 'dart:async';
import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:flutter_social/models/user.dart';
import 'service_utils.dart';

part 'users_service.chopper.dart';

@ChopperApi(baseUrl: 'users/')
abstract class UsersService extends ChopperService {
  @Get(path: 'people.json')
  @FactoryConverter(response: userListResponseConverter)
  Future<Response<APIUserList>> getPeopleToFollow({@Query() int page = 1});

  @Get(path: '{id}/followers.json')
  @FactoryConverter(response: userListResponseConverter)
  Future<Response<APIUserList>> getFollowers(@Path() int id,
      {@Query() int page = 1});

  @Get(path: '{id}/following.json')
  @FactoryConverter(response: userListResponseConverter)
  Future<Response<APIUserList>> getFollowing(@Path() int id,
      {@Query() int page = 1});

  @Get(path: '{id}.json')
  @FactoryConverter(response: userResponseConverter)
  Future<Response<APIUser>> getUser(@Path() int id);

  @Get(path: 'me.json')
  @FactoryConverter(response: userResponseConverter)
  Future<Response<APIUser>> getMyProfile();

  @Get(path: '{id}/is_following.json')
  @FactoryConverter(response: isFollowingResponseConverter)
  Future<Response<bool>> isFollowing(@Path() int id);

  @Put(path: '{id}/follow', optionalBody: true)
  Future<Response> followUser(@Path() int id);

  @Put(path: '{id}/unfollow', optionalBody: true)
  Future<Response> unfollowUser(@Path() int id);

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

  static FutureOr<Response> userListResponseConverter(Response response) {
    var body = response.body;
    final mapData = json.decode(body);
    final data = APIUserList.fromJson(mapData);
    return response.copyWith(body: data);
  }

  static FutureOr<Response> userResponseConverter(Response response) {
    var body = response.body;
    final mapData = json.decode(body);
    final data = APIUser.fromJson(mapData);
    return response.copyWith(body: data);
  }

  static FutureOr<Response> isFollowingResponseConverter(Response response) {
    var body = response.body;
    final mapData = json.decode(body);
    final data = mapData['result'];
    return response.copyWith(body: data);
  }
}
