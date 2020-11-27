import 'package:c45/models/favorito_model.dart';
import 'package:test/test.dart';

void main() {
  group('Favorito', () {
    test('Creacion de Favorito', () {
      var fab = Favorito(nombre: 'Santi', id: '1234');

      expect(fab.puntos, 1);
    });
  });
}
