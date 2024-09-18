import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class ViagemService {
  final ViagemRepositoryImpl _repository;
  final BarcoRepositoryImpl _barcoRepository;

  ViagemService(this._repository, this._barcoRepository);

  Future<int> salvarViagem(Viagem viagem) async {
    try {
      final viagemJson = viagem.toJson();
      return await _repository.insertRecord(viagemJson);
    } catch (e) {
      throw Exception('Erro ao salvar Viagem');
    }
  }

  Future<Viagem> getViagemId(int id) async {
    try {
      // final resultado = await _repository.getByIdRecord(id);
      final viagemJson = Map<String, dynamic>.from(
          (await _repository.getByIdRecord(id)).first);
      final barcoJson = (await _barcoRepository
              .getByIdRecord(viagemJson[DbViagemKeys.idBarcoColuna]))
          .first;
      viagemJson['barco'] = Barco.fromJson(barcoJson);
      // viagemJson['barco'] = await _barcoRepository
      //     .getByIdRecord(viagemJson[DbViagemKeys.idBarcoColuna]);
      Viagem viagem = Viagem.fromJson(viagemJson);
      return viagem;
    } catch (e) {
      throw Exception('Erro ao buscar no banco a viagem');
    }
  }

  Future<List<Viagem>> getViagemPorBarco(int idBarco) async {
    try {
      final resultados = await _repository.getViagensPorBarco(idBarco);
      final List<Viagem> viagens = [];

      for (var json in resultados) {
        final viagemJson = Map<String, dynamic>.from(json);
        final barcoJson = (await _barcoRepository
                .getByIdRecord(viagemJson[DbViagemKeys.idBarcoColuna]))
            .first;
        viagemJson['barco'] = Barco.fromJson(barcoJson);

        viagens.add(Viagem.fromJson(viagemJson));
      }

      return viagens;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Erro ao buscar as viagens no banco de dados");
    }
  }

  Future<Map<String, dynamic>> getViagemRelatorio(int idViagem) async {
    try {
      final resultados = await _repository.getViagemRelatorio(idViagem);
      return resultados.first;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Erro ao buscar os dados do relatório da viagem");
    }
  }
}
