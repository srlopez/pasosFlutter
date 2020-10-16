import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class UserRepository {
  static Future<List<User>> fechtNextPage(int page, [int rows = 20]) async {
    String query = '&page=$page&results=$rows&nat=es';
    String url = Uri.encodeFull('https://randomuser.me/api/?seed=abc&$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      final list = (data['results'] as List).map((i) => User.fromJson(i));
      return list.toList();
    } else {
      return [];
    }
  }
}

abstract class Services {
  Future<List<User>> fechtNextPage(int page, [int rows]);

  Future<User> updateUser(User user);

  Future addUser();
}

class HttpServices implements Services {
  @override
  Future<List<User>> fechtNextPage(int page, [int rows = 20]) async {
    String query = '&page=$page&results=$rows&nat=es';
    String url = Uri.encodeFull('https://randomuser.me/api/?seed=abc&$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      final list = (data['results'] as List).map((i) => User.fromJson(i));
      return list.toList();
    } else {
      return [];
      //throw Exception('Fallo de Red');
    }
  }

  Future<User> getUser() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/todos?userId=1');

    if (response.statusCode == 200) {
      var user = User.fromJson(json.decode(response.body));
      return user;
    } else {}
  }

  @override
  Future addUser() {
    return null;
  }

  @override
  Future<User> updateUser(User user) async {
    // POST
    return user;
  }
}
