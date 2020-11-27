import 'package:c45/models/favorito_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritosServiceHive {
  Box box;

  dispose() => box.close();

  Future<bool> initBox() async {
    await Hive.initFlutter();
    box = await Hive.openBox<Favorito>('favoritos');
    return true;
  }

  //getAll
  getAll() {
    box.toMap();
  }

  //add
  addItem(Favorito item) async {
    box.add(item);
  }

  //delete
  //update
  updateItem(Favorito item) {
    box.put(item.id, item);
  }
}
