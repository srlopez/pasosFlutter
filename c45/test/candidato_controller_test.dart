import '../lib/controllers/candidato_controller.dart';
import '../lib/models/candidato_model.dart';
import '../lib/services/candidato_services_randomuser.dart';

import 'package:test/test.dart';

main() {
  setUp(() {});

  group('Candidato Controller', () {
    test('Varios test', () async {
      var httpRandomUserServices = HttpRandomUserServices();
      var candidatoCtrl = CandidatoController(httpRandomUserServices);

      expect(candidatoCtrl.pagina == 0, true, reason: 'Leidas 1 páginas');
      List<Candidato> list = await candidatoCtrl.fechtCandidatos();
      print(list);
      //print(list.length);
      expect(list.length, 20, reason: 'Primeros 20 items');

      candidatoCtrl.fechtCandidatos().then((value) async {
        expect(value.length, 40, reason: 'Primeros 40 items');

        //expect(candidatoCtrl.pagina == 2, true);
      });

      expect(candidatoCtrl.pagina == 2, true, reason: 'Leidas 2 páginas');
    });
  });
}
