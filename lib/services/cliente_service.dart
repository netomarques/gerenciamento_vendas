import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/repository/repository.dart';

class ClienteService {
  final DataRepository _repository;

  ClienteService(this._repository);

  Future<Cliente> getClienteId(int id) async {
    try {
      final resultado = await _repository.getByIdRecord(id);
      Cliente cliente = List.generate(resultado.length, (index) => Cliente.fromJson(resultado[index])).first;
      return cliente;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Cliente');
    }
  }
}
