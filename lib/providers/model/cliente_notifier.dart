import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/repository/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/services/service.dart';

class ClienteNotifier extends StateNotifier<ClienteState> {
  // final DataRepository _repository;
  final ClienteService _clienteService;

  ClienteNotifier(this._clienteService) : super(const ClienteState.initial()) {
    getClientes();
  }

  Future<void> salvarCliente(Cliente cliente) async {
    try {
      await _clienteService.salvarCliente(cliente);
      getClientes();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getClientes() async {
    try {
      final list = await _clienteService.getClientes();
      state = state.copyWith(list: list);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> atualizarCliente(Cliente cliente) async {
    try {
      await _clienteService.atualizarCliente(cliente);
      getClientes();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deletarCliente(int id) async {
    try {
      await _clienteService.deletarCliente(id);
      getClientes();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
