import 'package:c45/models/candidato_model.dart';
import 'package:test/test.dart';

void main() {
  group('Candidato', () {
    test('Creacion de Candidato', () {
      var persona = Candidato(nombre: 'Santi', id: '1234', email: 'e@mail.com');

      expect(persona.nombre, 'Santi');
    });
  });
}
