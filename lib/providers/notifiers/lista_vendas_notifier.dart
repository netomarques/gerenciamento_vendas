import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class ListaVendasNotifier extends StateNotifier<ListaVendasState> {
  final VendaService _vendaService;

  ListaVendasNotifier(this._vendaService)
      : super(
          ListaVendasState.initial(
            startDate: DateTime(1900),
            endDate: DateTime.now(),
            totalDaVendaFiado: Decimal.zero,
            totalDaVendaRua: Decimal.zero,
            totalDasVendas: Decimal.zero,
          ),
        ) {
    getVendasLazyLoading();
  }

  // void salvarVenda(Venda venda) async {
  //   try {
  //     await _vendaService.salvarVenda(venda);
  //     getVendas();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  Future<int> salvarVendaRua(Venda venda, Abatimento abatimento) async {
    try {
      final idVenda = await _vendaService.salvarVendaRua(venda, abatimento);
      getVendasLazyLoading();
      return idVenda;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> salvarVendaFiado(Venda venda, Abatimento? abatimento) async {
    try {
      final idVenda = await _vendaService.salvarVendaFiado(venda, abatimento);
      getVendasLazyLoading();
      return idVenda;
    } catch (e) {
      throw Exception(e);
    }
  }

  void getVendas() async {
    try {
      state = state.copyWith(carregando: true);

      final List<Venda> vendas = await _vendaService.getVendas();

      state = state.copyWith(list: vendas, carregando: false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getVendasLazyLoading({bool carregarMaisVendas = false}) async {
    final limit = state.limit;
    final offset = state.list.length;
    final dbStartDate = Helpers.formatarDateTimeToDateDB(state.startDate);
    final dbEndDate = Helpers.formatarDateTimeToDateDB(state.endDate);
    List<Venda> vendas = [];

    try {
      state = state.copyWith(carregando: true);

      if (!carregarMaisVendas) {
        vendas = await _vendaService.getVendasLazyLoading(
            limit, 0, dbStartDate, dbEndDate);
      } else {
        vendas = List<Venda>.from(state.list);
        final maisVendas = await _vendaService.getVendasLazyLoading(
            limit, offset, dbStartDate, dbEndDate);
        vendas.addAll(maisVendas);
      }
      _calcularResumo(vendas);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _calcularResumo(List<Venda> vendas) {
    Decimal totalDasVendas = Decimal.zero;
    Decimal totalVendaRua = Decimal.zero;
    Decimal totalVendaFiado = Decimal.zero;
    int qtdeVendaRua = 0;
    int qtdeVendaFiado = 0;

    for (Venda venda in vendas) {
      totalDasVendas += venda.total!;
      if (venda.fiado!) {
        qtdeVendaFiado += 1;
        totalVendaFiado += venda.total!;
      } else {
        qtdeVendaRua += 1;
        totalVendaRua += venda.total!;
      }
    }
    state = state.copyWith(
      list: vendas,
      totalDasVendas: totalDasVendas,
      qtdeVendaRua: qtdeVendaRua,
      qtdeVendaFiado: qtdeVendaFiado,
      totalDaVendaRua: totalVendaRua,
      totalDaVendaFiado: totalVendaFiado,
      carregando: false,
    );
  }

  void getVendasPorData(DateTime startDate, DateTime endDate) async {
    final limit = state.limit;
    const offset = 0;
    String dbStartDate = Helpers.formatarDateTimeToDateDB(startDate);
    String dbEndDate = Helpers.formatarDateTimeToDateDB(endDate);

    try {
      state = state.copyWith(
        carregando: true,
        startDate: startDate,
        endDate: endDate,
      );

      final List<Venda> vendas = await _vendaService.getVendasLazyLoading(
        limit,
        offset,
        dbStartDate,
        dbEndDate,
      );

      state = state.copyWith(
        startDate: startDate,
        endDate: endDate,
      );
      _calcularResumo(vendas);
    } catch (e) {
      state = state.copyWith(carregando: false);
      debugPrint(e.toString());
    }
  }

  Future<void> updateRecord(Map<String, dynamic> values, int id) async {
    try {
      // await _repository.updateRecord(values, id);
      getVendas();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteRecord(int id) async {
    try {
      // await _repository.deleteRecord(id);
      getVendas();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
