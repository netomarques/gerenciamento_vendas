import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';

class VendaNotifier extends Notifier<VendaState> {
  VendaService get _vendaService => ref.read(vendaServiceProvider);

  VendaNotifier(this._venda);

  final Venda _venda;

  @override
  VendaState build() => VendaState.initial(venda: _venda);

  Future<void> getVenda() async {
    final Venda venda;
    final List<Abatimento> abatimentos;
    int idVenda = _venda.id!;
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
