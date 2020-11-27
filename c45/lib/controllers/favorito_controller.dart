import 'dart:async';

import '../services/favorito_services_base.dart';
import '../models/favorito_model.dart';

class FavoritoController {
  FavoritoController(this.services);

  final FavoritoServices services;

  List<Favorito> _lista = [];
  List<Favorito> get lista => _lista;

  Future<List<Favorito>> getAll() async {
    _lista = await services.getAll();
    return _lista;
  }

  Future<bool> saveAll() async {
    services.saveAll(_lista);
    return true;
  }

  Future<bool> save(Favorito element) async {
    services.save(_lista, element);
    return true;
  }
  Future<bool> delete(Favorito element) async {
    services.delete(_lista, element);
    return true;
  }

}
