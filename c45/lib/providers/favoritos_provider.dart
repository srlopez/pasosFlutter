import 'package:flutter/material.dart';
import '../models/favorito_model.dart';
import '../models/candidato_model.dart';

class Favoritos with ChangeNotifier {
  var lista = <Favorito>[];
  var maxFavoritos = 5;

  bool esFavorito(Candidato candidato) {
    return lista.fold(
        false,
        (previousValue, favorito) =>
            (favorito.id == candidato.id) || previousValue);
  }

  void addFavorito(Candidato candidato) {
    if (lista.length < maxFavoritos && !esFavorito(candidato))
      lista.add(Favorito(nombre: candidato.nombre, id: candidato.id));
    notifyListeners();
  }

  void removeFavorito(Candidato candidato) {
    lista.remove(lista.firstWhere((favorito) => favorito.id == candidato.id));
    notifyListeners();
  }
}
