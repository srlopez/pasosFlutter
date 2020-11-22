import 'package:http/http.dart' as http;
import 'dart:convert';

import 'candidato_services_base.dart';
import '../models/candidato_model.dart';

class HttpRandomUserServices implements CandidatoServices {
  final urlBase = 'https://randomuser.me/api/?seed=abc&nat=es';

  Candidato itemToCandidato(Map<String, dynamic> json) {
    return Candidato(
      nombre: '${json['name']['first']} ${json['name']['last']}',
      id: json['id']['value'] as String,
      email: json['email'] as String,
    );
  }

  @override
  Future<List<Candidato>> fechtCandidatos(int pagina, [int items = 20]) async {
    String query = '&page=$pagina&results=$items';
    String url = Uri.encodeFull('$urlBase&$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      final list =
          (data['results'] as List).map((item) => itemToCandidato(item));
      return list.toList();
    } else {
      return [];
      //throw Exception('Fallo de Red');
    }
  }

  @override
  Future<Candidato> getCandidato(int id) async {
    // TODO: getCandidato
    String query = 'results=1';
    String url = Uri.encodeFull('$urlBase&$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var candidato = itemToCandidato(json.decode(response.body));
      return candidato;
    } else {
      return null;
    }
  }

  @override
  Future addCandidato() {
    // TODO: addCandidato
    // POST
    return null;
  }

  @override
  Future<Candidato> updateCandidato(Candidato candidato) async {
    // TODO: updateCandidato
    // POST-PUT
    return candidato;
  }
}
