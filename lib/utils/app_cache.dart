import 'package:flutter_social/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kAuthToken = 'authToken';
  static const kUserId = 'userId';
  static const kUserName = 'userName';
  static const kUserEmail = 'userEmail';
  static const kUserAbout = 'userAbout';
  static const kUserCreatedAt = 'userCreatedAt';

  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kAuthToken, token);
  }

  Future<APIUser> get currentUser async {
    final prefs = await SharedPreferences.getInstance();

    return APIUser(
      id: prefs.getInt(kUserId)!,
      name: prefs.getString(kUserName)!,
      email: prefs.getString(kUserEmail)!,
      about: prefs.getString(kUserAbout)!,
      createdAt: DateTime.parse(prefs.getString(kUserCreatedAt)!),
    );
  }

  Future<void> saveCurrentUser(APIUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(kUserId, user.id);
    await prefs.setString(kUserName, user.name);
    await prefs.setString(kUserEmail, user.email ?? '');
    await prefs.setString(kUserAbout, user.about);
    await prefs.setString(kUserCreatedAt, user.createdAt.toString());
  }

  Future<String> authToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kAuthToken)!;
  }

  Future<int> currentUserId() async {
    final user = await currentUser;
    return user.id;
  }

  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kAuthToken);
    await prefs.remove(kUserId);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(kAuthToken) &&
        prefs.getString(kAuthToken)!.isNotEmpty;
  }
}
