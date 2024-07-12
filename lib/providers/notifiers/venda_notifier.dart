import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendaNotifier extends StateNotifier<VendaState> {
  final VendaService _vendaService;

  VendaNotifier(this._vendaService, Venda venda)
      : super(const VendaState.initial()) {
    _setVenda(venda);
  }

  _setVenda(Venda venda) {
    state = state.copyWith(venda: venda);
  }

  void getVenda() async {
    final Venda venda;
    final List<Abatimento> abatimentos;
    int idVenda = state.venda!.id!;
    try {
      state = state.copyWith(carregando: true);
      venda = await _vendaService.getVendaId(idVenda);
      abatimentos = await _vendaService.getAbatimentosPorVenda(idVenda);
      state = state.copyWith(
          venda: venda, abatimentosDaVenda: abatimentos, carregando: false);
    } catch (e) {
      state = state.copyWith(carregando: false);
      debugPrint(e.toString());
    }
  }

  void limparDados() {
    state = state.copyWith(
      abatimentosDaVenda: const [],
      carregando: false,
    );
  }
}
