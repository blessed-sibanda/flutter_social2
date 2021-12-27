import 'package:flutter/foundation.dart';
import 'package:flutter_social/models/user.dart';

class PeopleProvider extends ChangeNotifier {
  final _whoToFollow = <APIUser>{};

  List<APIUser> get peopleToFollow => _whoToFollow.toList();

  void addPeopleToFollow(List<APIUser> users) {
    for (final user in users) {
      _whoToFollow.add(user);
    }

    // _whoToFollow.clear();

    _whoToFollow.toList().sort((a, b) => a.id.compareTo(b.id));
    notifyListeners();
  }

  void removePerson(APIUser user) {
    _whoToFollow.remove(user);
    notifyListeners();
  }

  void clearList() {
    _whoToFollow.clear();
    notifyListeners();
  }
}
