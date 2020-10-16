// El modelo
import 'package:flutter/foundation.dart';

class User {
  // Atrubutos
  String nombre;
  String dni;
  int valor;
  String email;

  // Constructor
  User({
    @required this.nombre,
    @required this.dni,
    @required this.valor,
    @required this.email,
  });

  // Conversion de Json a objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nombre: '${json['name']['first']} ${json['name']['last']}',
      dni: json['id']['value'] as String,
      valor: json['dob']['age'] as int,
      email: json['email'] as String,
    );
  }

  // Hacer la inversa, de objeto User a Map

}
