import 'package:test/test.dart';

import '../lib/services/favorito_services_hive.dart';
import '../lib/models/favorito_model.dart';

void main() {
  group('Favorito', () {
    test('Creacion de Favorito', () {
      var fav = Favorito(nombre: 'Santi', id: '1234');

      expect(fav.puntos, 1);
    });
    // test('Add Favorito Hive', () {
    //   var fav = Favorito(nombre: 'Santi', id: '1234');

    //   var service = FavoritosServiceHive();
    //   service.initBox(test: false);
    //   service.addFavorito(fav);
    //   print(service.box.toMap());
    //   expect(fav.puntos, 1);
    // });
  });
}
