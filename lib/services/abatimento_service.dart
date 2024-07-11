import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';

class AbatimentoService {
  final AbatimentoRepositoryImpl _repository;

  AbatimentoService(this._repository);

  Future<void> salvarAbatimento(Abatimento abatimento) async {
    try {
      final abatimentoJson = abatimento.toJson();
      await _repository.insertRecord(abatimentoJson);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao salvar Abatimento');
    }
  }
}
