import '../models/user_model.dart';

abstract class Services {
  Future<List<User>> fechtUsers(int page, [int rows]);

  Future<User> updateUser(User user);

  Future addUser();

  Future<User> getUser(int id);
}
