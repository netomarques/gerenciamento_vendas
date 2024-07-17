import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class ListaVendasNotifier extends StateNotifier<ListaVendasState> {
  final VendaService _vendaService;

  ListaVendasNotifier(this._vendaService)
      : super(ListaVendasState.initial(
            startDate: DateTime(1900), endDate: DateTime.now())) {
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
    int limit = state.limit;
    int offset = state.list.length;
    List<Venda> vendas = [];
    String dbStartDate = Helpers.dateTimeToDbDate(
        Helpers.formatarDateTimeToString(state.startDate));
    String dbEndDate = Helpers.dateTimeToDbDate(
        Helpers.formatarDateTimeToString(state.endDate));

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
    double totalDasVendas = 0.0;
    double totalVendaRua = 0.0;
    double totalVendaFiado = 0.0;
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
    int limit = state.limit;
    int offset = 0;
    String dbStartDate =
        Helpers.dateTimeToDbDate(Helpers.formatarDateTimeToString(startDate));
    String dbEndDate =
        Helpers.dateTimeToDbDate(Helpers.formatarDateTimeToString(endDate));

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
