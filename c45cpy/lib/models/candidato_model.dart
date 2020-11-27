// El modelo
import 'package:meta/meta.dart';

class Candidato {
  // Atrubutos
  String nombre;
  String id;
  String email;

  // Constructor
  Candidato({
    @required this.nombre,
    @required this.id,
    @required this.email,
  });

  @override
  String toString() {
    return '$id $nombre ';
  }
}
