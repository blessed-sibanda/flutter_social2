import 'package:flutter/foundation.dart';

class CurrentPasswordProvider extends ChangeNotifier {
  bool _valid = true;

  bool get isInvalid => !_valid;

  void invalidate() {
    _valid = false;
    notifyListeners();
  }

  void validate() {
    _valid = true;
    notifyListeners();
  }
}
