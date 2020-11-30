import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/favorito_model.dart';
import 'favorito_services_base.dart';

class FavoritoServiceHive extends FavoritoServices {
  var boxName = 'favoritos';
  Box box;

  dispose() => box.close();

  @override
  Future<FavoritoServices> init() async {
    Hive.registerAdapter(FavoritoAdapter());
    await Hive.initFlutter();

    box = await Hive.openBox<Favorito>(boxName);
    print('Service HIVE');

    return this;
  }

  @override
  Future<List<Favorito>> getAll() async {
    //print(box.toMap());
    return box.values.toList();
  }

  @override
  Future<bool> saveAll(List<Favorito> lf) async {
    // borramos todo
    await box.deleteAll(box.keys);
    // insertamos todo
    //box.addAll(lf);
    lf.forEach((e) => box.put(e.id, e));
    return true;
  }

  @override
  Future<bool> save(List<Favorito> lista, Favorito e) async {
    box.put(e.id, e);
    return true;
  }

  @override
  Future<bool> delete(List<Favorito> lista, Favorito e) async {
    box.delete(e.id);
    return true;
  }
}
