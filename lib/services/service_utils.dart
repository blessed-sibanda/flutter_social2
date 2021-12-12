import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:flutter_social/utils/app_cache.dart';

class ServiceUtils {
  static const String kBaseUrl = 'http://192.168.43.72:3000';

  static Future<Request> addAuthorization(Request req) async {
    final headers = Map<String, String>.from(req.headers);
    final appCache = AppCache();
    bool isLoggedIn = await appCache.isUserLoggedIn();
    if (isLoggedIn) headers['Authorization'] = await appCache.authToken();
    return req.copyWith(headers: headers);
  }
}
