// El modelo
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
