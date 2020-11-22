import '../models/candidato_model.dart';

abstract class CandidatoServices {
  Future<List<Candidato>> fechtCandidatos(int page, [int rows]);

  Future<Candidato> updateCandidato(Candidato candidato);

  Future addCandidato();

  Future<Candidato> getCandidato(int id);
}
