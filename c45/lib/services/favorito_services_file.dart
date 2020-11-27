import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/favorito_model.dart';
import 'favorito_services_base.dart';

class FavoritoServicesFile extends FavoritoServices {
  Directory directory;
  File horarioFile;

  FavoritoServicesFile({var this.directory}) {
    //print(directory?.path ?? 'null directory.path');
  }
  final separator = '¬';

  String favoritoToString(Favorito f) =>
      '${f.id}$separator${f.nombre}$separator${f.puntos}';

  Favorito favoritoFromString(String s) {
    var member = s.split(separator);
    var f = Favorito(id: member[0], nombre: member[1]);
    f.puntos = int.parse(member[2]);
    return f;
  }

  Future<String> get _localPath async {
    directory = directory ?? await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = directory?.path ?? await _localPath;
    return File('$path/favoritos.txt').create(recursive: true);
  }

  @override
  Future<FavoritoServices> init() async => this;

  @override
  Future<List<Favorito>> getAll() async {
    try {
      var lf = <Favorito>[];
      final file = await _localFile;

      List<String> lines = file.readAsLinesSync();
      lines.forEach((line) => lf.add(favoritoFromString(line)));
      return lf;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<bool> saveAll(List<Favorito> lf) async {
    final file = await _localFile;
    var sb = StringBuffer();
    lf.forEach((element) => sb.writeln(favoritoToString(element)));
    file.writeAsString(sb.toString());

    return true;
  }

  @override
  Future<bool> delete(List<Favorito> lista, Favorito element) {
    return saveAll(lista);
  }

  @override
  Future<bool> save(List<Favorito> lista, Favorito element) {
    return saveAll(lista);
  }
}
