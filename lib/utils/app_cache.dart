import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kAuthToken = 'authToken';

  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kAuthToken, "Bearer $token");
  }

  Future<String> authToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kAuthToken)!;
  }

  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kAuthToken);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(kAuthToken) &&
        prefs.getString(kAuthToken)!.isNotEmpty;
  }
}
