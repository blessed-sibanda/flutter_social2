import 'app_paths.dart';

class AppLink {
  // Constants for each query parameter
  static const String kUserIdParam = 'userId';

  String? location;
  int? userId;

  AppLink({this.location, this.userId});

  static AppLink fromLocation(String location) {
    location = Uri.decodeFull(location);
    final uri = Uri.parse(location);
    final params = uri.queryParameters;

    void trySet(String key, void Function(String) setter) {
      if (params.containsKey(key)) setter.call(params[key]!);
    }

    final link = AppLink()..location = uri.path;

    trySet(AppLink.kUserIdParam, (s) => link.userId = int.tryParse(s));

    return link;
  }

  String toLocation() {
    String addKeyValuePair({String? key, String? value}) =>
        value == null ? '' : '$key=$value';

    switch (location) {
      case AppPaths.authPath:
        return AppPaths.authPath;

      case AppPaths.peoplePath:
        return AppPaths.peoplePath;

      case AppPaths.userEditPath:
        return AppPaths.userEditPath;

      case AppPaths.userPath:
        var loc = '${AppPaths.userPath}?';
        loc += addKeyValuePair(key: kUserIdParam, value: userId.toString());
        return Uri.encodeFull(loc);

      default:
        return AppPaths.homePath;
    }
  }
}
