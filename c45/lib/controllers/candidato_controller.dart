import 'dart:async';

import '../services/candidato_services_base.dart';
import '../models/candidato_model.dart';

class CandidatoController {
  CandidatoController(this.services);

  // El servicio hhtp del que vamos a obtener datos
  final CandidatoServices services;

  // Mantiene la lista de datos obtenidos, y la cual será la siguiente página
  List<Candidato> _candidatos = [];
  int _proximaPage = 0;
  int get pagina => _proximaPage;
  //List<Candidato> get candidatos => _candidatos;

  // Stream para conocer si estamos haciendo una lectura de datos
  StreamController<bool> _onSyncController = StreamController();
  Stream<bool> get onSync => _onSyncController.stream;
  //Stream<bool> get onSyncB => _onSyncController.stream.asBroadcastStream();
  bool get hasListener => _onSyncController.hasListener;

  // Lectura de Candidatos
  // Si pagina es <1, obtiene la siguiente página
  Future<List<Candidato>> fechtCandidatos(
      {int pagina = 0, int items = 20}) async {
    var npag = pagina == 0 ? _proximaPage++ : pagina;
    //print('fechtCandidatos: $npag, $_proximaPage');

    _onSyncController.add(true); //<- Indicamos que estamos en lectura
    var _results = await services.fechtCandidatos(npag, items);
    _onSyncController.add(false); //<- Finalización de la lectura
    _candidatos.addAll(_results);

    return _candidatos; // Devolmenos siempre la lista que mantenemos
  }

  Future<Candidato> updateCandidato(
      // TODO: updateCandidato
      Candidato candidato,
      bool isCompleted) async {
    return await services.updateCandidato(candidato);
  }
}
