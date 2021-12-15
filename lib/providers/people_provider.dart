import 'package:flutter/foundation.dart';
import 'package:flutter_social/models/user.dart';

class PeopleProvider extends ChangeNotifier {
  final _whoToFollow = <APIUser>[];

  List<APIUser> get peopleToFollow => _whoToFollow;

  void addPeopleToFollow(List<APIUser> users) {
    final peopleIds = _whoToFollow.map((p) => p.id).toList();
    for (final user in users) {
      if (!peopleIds.contains(user.id)) {
        _whoToFollow.add(user);
      }
    }
    _whoToFollow.sort((a, b) => a.id.compareTo(b.id));
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
