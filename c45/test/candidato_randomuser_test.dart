import 'package:c45/services/candidato_services_randomuser.dart';

import 'package:test/test.dart';

main() {
  setUp(() {});

  group('Candidato Services', () {
    test('Creado de json', () {
      final apiProvider = HttpRandomUserServices();

      var persona = apiProvider.itemToCandidato({
        'name': {'first': 'Santi', 'last': 'Lopez'},
        'id': {'value': '1234'},
        'email': 'e@mail.com'
      });
      expect(persona.nombre, 'Santi Lopez');
    });

    test('Obtenemos la primera página de 30', () async {
      // Setup
      final apiProvider = HttpRandomUserServices();
      // Ejecucion
      var list = await apiProvider.fechtCandidatos(1, 30);
      list.forEach((element) {
        //print('$element');
      });
      print('length: ${list.length}');

      // Verificacion
      expect(list.length, 30);
    });
  });
}
