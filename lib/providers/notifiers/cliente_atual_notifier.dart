import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class ClienteAtualNotifier extends Notifier<ClienteAtualState> {
  ClienteService get _clienteService => ref.read(clienteServiceProvider);
  VendaService get _vendaService => ref.read(vendaServiceProvider);

  final Cliente _cliente;

  ClienteAtualNotifier(this._cliente);

  static const _pageSize = 10;

  @override
  ClienteAtualState build() =>
      ClienteAtualState.initial(totalEmAberto: Decimal.zero, cliente: _cliente);

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

  Future<void> getVendasPorClienteLazyLoading(
      {DateTime? startDate, DateTime? endDate}) async {
    try {
      startDate ??= DateTime(1900);
      endDate ??= DateTime.now();

      state = state.copyWith(carregando: true);
      final clienteId = state.cliente.id!;

      final vendasDoCliente =
          await _vendaService.getVendasPorClienteLazyLoading(
              clienteId,
              _pageSize,
              0,
              Helpers.formatarDateTimeToDateDB(startDate),
              Helpers.formatarDateTimeToDateDB(endDate));

      final totalEmAberto =
          await _vendaService.getTotalEmAbertoDoCliente(clienteId);

      state = state.copyWith(
        vendasDoCliente: vendasDoCliente,
        totalEmAberto: totalEmAberto,
        carregando: false,
      );
    } catch (e) {
      state = state.copyWith(carregando: false);
      debugPrint('CLIENTE ATUAL NOTIFIER: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> getMaisVendasPorClienteLazyLoading(
      {DateTime? startDate, DateTime? endDate}) async {
    startDate ??= DateTime(1900);
    endDate ??= DateTime.now();
    int offset = state.vendasDoCliente.length;
    List<Venda> vendasDoCliente = List<Venda>.from(state.vendasDoCliente);

    try {
      state = state.copyWith(carregando: true);
      final clienteId = state.cliente.id!;

      final maisVendas = await _vendaService.getVendasPorClienteLazyLoading(
        clienteId,
        _pageSize,
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
