import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

abstract class Services {
  Future<List<User>> fechtNextPage(int page, [int rows]);

  Future<User> updateUser(User user);

  Future addUser();

  Future<User> getUser(int id);
}

class HttpServices implements Services {
  final urlBase = 'https://randomuser.me/api/?seed=abc&nat=es';

  @override
  Future<List<User>> fechtNextPage(int page, [int rows = 20]) async {
    String query = '&page=$page&results=$rows';
    String url = Uri.encodeFull('$urlBase&$query');

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

  @override
  Future<User> getUser(int id) async {
    String query = 'results=1';
    String url = Uri.encodeFull('$urlBase&$query');

    final response = await http.get(url);

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
