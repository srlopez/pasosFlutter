import 'dart:async';

import '../services/services_base.dart';
import '../models/user_model.dart';

class UserController {
  UserController(this.services);
  final Services services;

  List<User> users = [];
  int _nextPage = 1;

  StreamController<bool> onSyncController = StreamController();

  Stream<bool> get onSync => onSyncController.stream;

  Future<List<User>> fechtUsers([int page = 0, int rows = 20]) async {
    page = page == 0 ? _nextPage++ : page;
    print('page: $page, $_nextPage');

    onSyncController.add(true);
    var _upage = await services.fechtUsers(page, rows);
    onSyncController.add(false);
    users.addAll(_upage);
    return users;
  }

  Future<User> updateUser(User user, bool isCompleted) async {
    return await services.updateUser(user);
  }
}
