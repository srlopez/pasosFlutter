import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/favorito_model.dart';
import 'favorito_services_base.dart';

class FavoritoServiceLite extends FavoritoServices {
  var dbHelper = DatabaseHelper.instance;

  @override
  Future<FavoritoServices> init() async {
    // reference to our single class that manages the database
    dbHelper = DatabaseHelper.instance;
    print('Service LITE');
    return this;
  }

  @override
  Future<List<Favorito>> getAll() async {
    //print(box.toMap());
    Database db = await dbHelper.database;
    final allRows = await db.query('favoritos');
    var lista = <Favorito>[];
    allRows.forEach((row) => lista.add(favoritofromMap(row)));
    return lista;
  }

  @override
  Future<bool> saveAll(List<Favorito> lf) async {
    // borramos todo
    Database db = await dbHelper.database;
    db.execute('DELETE * FROM favoritos');
    // insertamos todo
    lf.forEach((element) => save(lf, element));
    return true;
  }

  @override
  Future<bool> save(List<Favorito> lista, Favorito e) async {
    delete(lista, e);
    Database db = await dbHelper.database;
    db.execute('INSERT INTO favoritos ( _id, nombre, puntos) VALUES ("' +
        e.id +
        '","' +
        e.nombre +
        '",' +
        e.puntos.toString() +
        ')');

    return true;
  }

  @override
  Future<bool> delete(List<Favorito> lista, Favorito e) async {
    Database db = await dbHelper.database;
    db.execute('DELETE FROM favoritos WHERE _id="' + e.id + '"');
    return true;
  }
}
// DTO ===========================

Favorito favoritofromMap(Map<String, dynamic> json) {
  var fav = Favorito(nombre: json['nombre'], id: json['_id']);
  print(json);
  //fav.puntos = int.parse(json['puntos']);
  fav.puntos = json['puntos'];
  return fav;
}

Map<String, dynamic> favoritoToMap(Favorito fav) {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['_id'] = fav.id;
  data['nombre'] = fav.nombre;
  data['puntos'] = fav.puntos;
  return data;
}

// DTO =========

class DatabaseHelper {
  static final _databaseName = "favoritos.db";
  static final _databaseVersion = 1;
  static final table = 'favoritos';

  static final columnId = '_id';
  static final columnName = 'nombre';
  static final columnPoints = 'puntos';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //String path = join(documentsDirectory.path, _databaseName);
    String path = documentsDirectory.path + _databaseName;
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnPoints INTEGER NOT NULL
          )
          ''');
  }
}
