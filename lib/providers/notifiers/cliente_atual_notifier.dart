import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ClienteAtualNotifier extends StateNotifier<ClienteAtualState> {
  final ClienteService _clienteService;
  final VendaService _vendaService;

  ClienteAtualNotifier(
    this._clienteService,
    this._vendaService,
    Cliente cliente,
  ) : super(const ClienteAtualState.initial()) {
    _setClienteState(cliente);
  }

  void atualizarCliente(Cliente cliente) async {
    try {
      await _clienteService.atualizarCliente(cliente);
      cliente = await _clienteService.getClienteId(cliente.id!);
      state = state.copyWith(cliente: cliente);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _setClienteState(Cliente cliente) async {
    state = state.copyWith(cliente: cliente);
  }

  void getVendasPorClienteLazyLoading({
    String startDate = "1900-01-01",
    String endDate = "",
  }) async {
    try {
      state = state.copyWith(carregando: true);

      if (endDate.isEmpty) {
        endDate = Helpers.formatarDateTimeToDateDB(DateTime.now());
      }

      final vendasDoCliente =
          await _vendaService.getVendasPorClienteLazyLoading(
              state.cliente!.id!, 10, 0, startDate, endDate);

      final totalEmAberto =
          await _vendaService.getTotalEmAbertoDoCliente(state.cliente!.id!);

      state = state.copyWith(
        vendasDoCliente: vendasDoCliente,
        totalEmAberto: totalEmAberto,
        carregando: false,
      );
    } catch (e) {
      state = state.copyWith(carregando: false);
      debugPrint(e.toString());
    }
  }

  void getMaisVendasPorClienteLazyLoading({
    String startDate = "1900-01-01",
    String endDate = "",
  }) async {
    int offset = state.vendasDoCliente.length;
    List<Venda> vendasDoCliente = List<Venda>.from(state.vendasDoCliente);

    if (endDate.isEmpty) {
      endDate = Helpers.formatarDateTimeToDateDB(DateTime.now());
    }

    try {
      state = state.copyWith(carregando: true);

      final maisVendas = await _vendaService.getVendasPorClienteLazyLoading(
        state.cliente!.id!,
        10,
        offset,
        startDate,
        endDate,
      );

      vendasDoCliente.addAll(maisVendas);

      state = state.copyWith(
        vendasDoCliente: vendasDoCliente,
        carregando: false,
      );
    } catch (e) {
      state = state.copyWith(carregando: false);
      debugPrint(e.toString());
    }
  }

  void limparDados() {
    state = state.copyWith(
      vendasDoCliente: const [],
      totalEmAberto: 0.0,
      carregando: false,
    );
  }
}
