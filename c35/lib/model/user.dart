// El modelo
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  // Atrubutos
  String nombre;
  String dni;

  // Constructor
  User({
    @required this.nombre,
    @required this.dni,
  });

  // Conversion de Json a objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nombre: '${json['name']['first']} ${json['name']['last']}',
      dni: json['id']['value'] as String,
    );
  }

  // Hacer la inversa, de objeto User a Map

}

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
