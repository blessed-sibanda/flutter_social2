import 'package:flutter/foundation.dart';

class CurrentPasswordProvider extends ChangeNotifier {
  bool _inValid = false;

  bool isInvalid() => _inValid;

  void invalidate() {
    _inValid = true;
    notifyListeners();
  }

  void validate() {
    _inValid = false;
    notifyListeners();
  }
}
