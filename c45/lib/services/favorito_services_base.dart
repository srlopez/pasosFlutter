import '../models/favorito_model.dart';

abstract class FavoritoServices {
  Future<FavoritoServices> init();

  Future<List<Favorito>> getAll();

  Future<bool> saveAll(List<Favorito> lista);

  Future<bool> save(List<Favorito> lista, Favorito element);

  Future<bool> delete(List<Favorito> lista, Favorito element);
}
