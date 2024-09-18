import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';

class BarcoService {
  final BarcoRepositoryImpl _repository;
  final ViagemRepositoryImpl _viagemRepository;

  BarcoService(this._repository, this._viagemRepository);

  Future<Barco> getBarco(int idBarco) async {
    try {
      final barcoJson = (await _repository.getByIdRecord(idBarco)).first;
      Barco barco = Barco.fromJson(barcoJson);
      return barco;
    } catch (e) {
      throw Exception("Erro ao buscar barco no banco de dados");
    }
  }

  Future<List<Viagem>> getViagensPorBarco(int idBarco) async {
    try {
      final resultados = await _viagemRepository.getViagensPorBarco(idBarco);
      final barcoJson = (await _repository.getByIdRecord(idBarco)).first;

      Barco barco = Barco.fromJson(barcoJson);
      final List<Viagem> viagens = [];
      for (var queryResult in resultados) {
        final viagemJson = Map<String, dynamic>.from(queryResult);
        viagemJson['barco'] = barco;
        viagens.add(Viagem.fromJson(viagemJson));
      }

      return viagens;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Erro ao buscar as viagens no banco de dados");
    }
  }

  Future<Map<String, dynamic>> getBarcoRelatorio(int idViagem) async {
    try {
      final resultados = await _repository.getBarcoRelatorio(idViagem);
      return resultados.first;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Erro ao buscar os dados do relatório do barco");
    }
  }
}
