import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kAuthToken = 'authToken';
  static const kUserId = 'userId';

  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kAuthToken, token);
  }

  Future<void> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(kUserId, id);
  }

  Future<String> authToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kAuthToken)!;
  }

  Future<int> currentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(kUserId)!;
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
