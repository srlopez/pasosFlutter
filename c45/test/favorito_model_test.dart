import 'package:test/test.dart';

import '../lib/models/favorito_model.dart';

void main() {
  group('Favorito', () {
    test('Creacion de Favorito', () {
      var fav = Favorito(nombre: 'Santi', id: '1234');

      expect(fav.puntos, 1);
    });
  });
}
