import 'package:flutter/material.dart';
import '../models/favorito_model.dart';
import '../models/candidato_model.dart';

class Favoritos with ChangeNotifier {
  var lista = <Favorito>[];

  addFavorito(Candidato candidato) {
    print(candidato);
    lista.add(Favorito(nombre: candidato.nombre, id: candidato.id));
    notifyListeners();
  }

  removeFavorito() {
    notifyListeners();
  }
}
