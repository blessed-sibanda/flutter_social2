import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_social/utils/app_cache.dart';

class AppProvider extends ChangeNotifier {
  final _appCache = AppCache();

  bool _initialized = false;
  bool _loggedIn = false;
  bool _didSelectUser = false;
  bool _onPeople = false;
  int _selectedUser = -1;
  bool _editingUser = false;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  int get selectedUser => _selectedUser;
  bool get editingUser => _editingUser;

  bool get didSelectUser => _didSelectUser;
  bool get onPeople => _onPeople;

  void _reset() {
    _didSelectUser = false;
    _onPeople = false;
    _editingUser = false;
    _selectedUser = -1;
  }

  void initializeApp() async {
    _loggedIn = await _appCache.isUserLoggedIn();
    Timer(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  void logIn() async {
    _loggedIn = await _appCache.isUserLoggedIn();
    notifyListeners();
  }

  void logOut() async {
    _loggedIn = false;
    _reset();
    await _appCache.invalidate();

    notifyListeners();
  }

  void goToHome() {
    _reset();
    notifyListeners();
  }

  void goToProfile({int userId = -1}) {
    // if userId = -1, it means the user is on his/her own profile
    _reset();
    _didSelectUser = true;
    _selectedUser = userId;
    notifyListeners();
  }

  void goToPeople() {
    _reset();
    _onPeople = true;
    notifyListeners();
  }

  void editUser() {
    _reset();
    _editingUser = true;
    notifyListeners();
  }
}
