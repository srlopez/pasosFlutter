// El modelo
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class Favorito {
  // Atributos
  String nombre;
  String id;
  int puntos = 1;

  // Constructor
  Favorito({
    @required this.nombre,
    @required this.id,
  });

  @override
  String toString() {
    return '($puntos) $nombre ';
  }
}
