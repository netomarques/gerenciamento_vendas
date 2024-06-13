import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/repository/repository.dart';

class ClienteService {
  final ClienteRepositoryImpl _repository;

  ClienteService(this._repository);

  Future<Cliente> getClienteId(int id) async {
    try {
      final resultado = await _repository.getByIdRecord(id);
      Cliente cliente = List.generate(
              resultado.length, (index) => Cliente.fromJson(resultado[index]))
          .first;
      return cliente;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Cliente');
    }
  }

  Future<void> salvarCliente(Cliente cliente) async {
    try {
      final clienteJson = cliente.toJson();
      await _repository.insertRecord(clienteJson);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao salvar Cliente');
    }
  }

  Future<List<Cliente>> getClientes() async {
    try {
      final resultados = await _repository.getAllRecords();
      final List<Cliente> clientes = [];

      for (var clienteJson in resultados) {
        clientes.add(Cliente.fromJson(clienteJson));
      }

      return clientes;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Erro ao consultar Clientes");
    }
  }

  Future<void> atualizarCliente(Cliente cliente) async {
    try {
      await _repository.updateRecord(cliente.toJson(), cliente.id!);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao atualizar Cliente');
    }
  }

  Future<void> deletarCliente(int id) async {
    try {
      await _repository.deleteRecord(id);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao deletar Cliente');
    }
  }
}
