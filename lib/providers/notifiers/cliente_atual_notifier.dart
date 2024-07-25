import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class ClienteAtualNotifier extends StateNotifier<ClienteAtualState> {
  final ClienteService _clienteService;
  final VendaService _vendaService;

  ClienteAtualNotifier(
    this._clienteService,
    this._vendaService,
    Cliente cliente,
  ) : super(ClienteAtualState.initial(totalEmAberto: Decimal.zero)) {
    // _getCliente(idCliente);
    _setClienteState(cliente);
  }

  Future<void> atualizarCliente(Cliente cliente) async {
    try {
      await _clienteService.atualizarCliente(cliente);
      final clienteAtualizado = await _clienteService.getClienteId(cliente.id!);
      state = state.copyWith(cliente: clienteAtualizado);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void _setClienteState(Cliente cliente) async {
    state = state.copyWith(cliente: cliente);
  }

  void getVendasPorClienteLazyLoading(
      {DateTime? startDate, DateTime? endDate}) async {
    try {
      startDate ??= DateTime(1900);
      endDate ??= DateTime.now();

      state = state.copyWith(carregando: true);

      final vendasDoCliente =
          await _vendaService.getVendasPorClienteLazyLoading(
              state.cliente!.id!,
              10,
              0,
              Helpers.formatarDateTimeToDateDB(startDate),
              Helpers.formatarDateTimeToDateDB(endDate));

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
      rethrow;
    }
  }

  void getMaisVendasPorClienteLazyLoading(
      {DateTime? startDate, DateTime? endDate}) async {
    startDate ??= DateTime(1900);
    endDate ??= DateTime.now();
    int offset = state.vendasDoCliente.length;
    List<Venda> vendasDoCliente = List<Venda>.from(state.vendasDoCliente);

    try {
      state = state.copyWith(carregando: true);

      final maisVendas = await _vendaService.getVendasPorClienteLazyLoading(
        state.cliente!.id!,
        10,
        offset,
        Helpers.formatarDateTimeToDateDB(startDate),
        Helpers.formatarDateTimeToDateDB(endDate),
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
      totalEmAberto: Decimal.zero,
      carregando: false,
    );
  }
}
