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

  void removeCandidato(Candidato candidato) {
    removeFavorito(lista.firstWhere((favorito) => favorito.id == candidato.id));
  }

  void removeFavorito(Favorito favorito) {
    lista.remove(favorito);
    notifyListeners();
  }

  void addIncrement(Favorito favorito, int delta) {
    favorito.puntos += delta;
    if (favorito.puntos < 1) favorito.puntos = 1;
    if (favorito.puntos > 3) favorito.puntos = 3;
    notifyListeners();
  }
}
