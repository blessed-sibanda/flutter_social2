import 'package:flutter/foundation.dart';

enum AuthScreenPage { signIn, signUp }

class AuthScreenProvider extends ChangeNotifier {
  AuthScreenPage _currentPage = AuthScreenPage.signIn;

  AuthScreenPage get currentPage => _currentPage;

  void goToSignUp() {
    _currentPage = AuthScreenPage.signUp;
    notifyListeners();
  }

  void goToSignIn() {
    _currentPage = AuthScreenPage.signIn;
    notifyListeners();
  }
}
