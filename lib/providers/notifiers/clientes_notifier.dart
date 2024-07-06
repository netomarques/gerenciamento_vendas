import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientesNotifier extends StateNotifier<ClientesState> {
  final ClienteService _clienteService;

  ClientesNotifier(this._clienteService)
      : super(const ClientesState.initial()) {
    getClientesLazyLoading();
  }

  Future<void> salvarCliente(Cliente cliente) async {
    try {
      await _clienteService.salvarCliente(cliente);
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

  void getClientesLazyLoading() async {
    state = state.copyWith(carregando: true, filtroPorNome: false);

    try {
      final int limit = state.limit;
      const int offset = 0;
      final list = await _clienteService.getClientesLazyLoading(limit, offset);

      state = state.copyWith(list: list, carregando: false);
    } catch (e) {
      state = state.copyWith(carregando: false);
      debugPrint(e.toString());
    }
  }

  void carregarMaisClientesLazyLoading() async {
    state = state.copyWith(carregando: true);

    try {
      List<Cliente> listaAtualizada = List<Cliente>.from(state.list);
      // List<Cliente> maisClientes;
      final limit = state.limit;
      int offSet = state.list.length;

      final maisClientes =
          await _clienteService.getClientesLazyLoading(limit, offSet);
      if (maisClientes.isNotEmpty) {
        listaAtualizada.addAll(maisClientes);
      }

      state = state.copyWith(list: listaAtualizada, carregando: false);
    } catch (e) {
      state = state.copyWith(carregando: false);
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

  void getClientesFiltradosLazyLoading(String nome,
      {bool carregarMais = false}) async {
    state = state.copyWith(carregando: true, filtroPorNome: true);
    List<Cliente> clientesFiltrados = [];

    try {
      final limit = state.limit;

      if (!carregarMais) {
        clientesFiltrados =
            await _clienteService.getClientesFiltroPorNome(nome, limit, 0);
      } else {
        clientesFiltrados = List<Cliente>.from(state.list);
        final maisClientesFiltrados = await _clienteService
            .getClientesFiltroPorNome(nome, limit, clientesFiltrados.length);
        clientesFiltrados.addAll(maisClientesFiltrados);
      }

      state = state.copyWith(list: clientesFiltrados, carregando: false);
    } catch (e) {
      state = state.copyWith(carregando: false);
      debugPrint(e.toString());
    }
  }

  // void limparLista() {
  //   // const List<Cliente> list = [];
  //   // state = state.copyWith(list: list, carregando: false);
  //   state = const ClientesState.initial();
  // }
}
