// El modelo y la Entidad
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';

part 'favorito_model.g.dart';

@HiveType(typeId: 0)
class Favorito {
  // Atributos
  @HiveField(0)
  String nombre;
  @HiveField(1)
  String id;
  @HiveField(2)
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
