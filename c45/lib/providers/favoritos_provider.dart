import 'package:flutter/material.dart';

import '../controllers/favorito_controller.dart';
import '../models/candidato_model.dart';
import '../models/favorito_model.dart';

class Favoritos with ChangeNotifier {
  var lista = <Favorito>[];
  var maxFavoritos = 5;
  FavoritoController controller;

  Favoritos({this.controller}) {
    controller.getAll().then((value) => lista = value);
  }

  bool esFavorito(Candidato candidato) {
    return lista.fold(
        false,
        (previousValue, favorito) =>
            (favorito.id == candidato.id) || previousValue);
  }

  void addFavorito(Candidato candidato) {
    if (lista.length < maxFavoritos && !esFavorito(candidato)) {
      var fav = Favorito(nombre: candidato.nombre, id: candidato.id);
      lista.add(fav);
      //controller.saveAll();
      controller.save(fav);
      notifyListeners();
    }
  }

  void removeCandidato(Candidato candidato) {
    removeFavorito(lista.firstWhere((favorito) => favorito.id == candidato.id));
  }

  void removeFavorito(Favorito favorito) {
    lista.remove(favorito);

    //controller.saveAll();
    controller.delete(favorito);
    notifyListeners();
  }

  void addIncrement(Favorito favorito, int delta) {
    favorito.puntos += delta;
    if (favorito.puntos < 1) favorito.puntos = 1;
    if (favorito.puntos > 3) favorito.puntos = 3;

    //controller.saveAll();
    controller.save(favorito);
    notifyListeners();
  }
}
