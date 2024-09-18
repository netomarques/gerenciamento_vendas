import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:vendas_gerenciamento/utils/helpers.dart';

class ViagemNotifier extends StateNotifier<ViagemRelatorioState> {
  final ViagemService _viagemService;
  final VendaService _vendaService;

  ViagemNotifier(this._viagemService, this._vendaService, Viagem viagem)
      : super(const ViagemRelatorioState.initial()) {
    _setViagem(viagem);
  }

  _setViagem(Viagem viagem) {
    state = state.copyWith(viagem: viagem);
  }

  void getViagem() async {
    try {
      state = state.copyWith(carregando: true);

      final vendas = await _vendaService.getVendasPorViagemLazyLoading(
        state.viagem!.id,
        10,
        0,
        Helpers.formatarDateTimeToDateDB(DateTime(1900)),
        Helpers.formatarDateTimeToDateDB(DateTime.now()),
      );
      final relatorio =
          await _viagemService.getViagemRelatorio(state.viagem!.id);
      if (relatorio.isNotEmpty) {
        final pesoTotal = relatorio['peso_total'] == null
            ? Decimal.zero
            : Decimal.parse(Decimal.parse(relatorio['peso_total'].toString())
                .toStringAsFixed(2));
        final pesoTotalVendido = relatorio['peso_total_vendido'] == null
            ? Decimal.zero
            : Decimal.parse(
                Decimal.parse(relatorio['peso_total_vendido'].toString())
                    .toStringAsFixed(2));
        final numeroDeVendas = relatorio['numero_de_vendas'] ?? 0;
        final totalDasVendas = relatorio['total_das_vendas'] == null
            ? Decimal.zero
            : Decimal.parse(
                Decimal.parse(relatorio['total_das_vendas'].toString())
                    .toStringAsFixed(2));
        final numeroVendaRua = relatorio['numero_venda_rua'] ?? 0;
        final totalVendaRua = relatorio['total_venda_rua'] == null
            ? Decimal.zero
            : Decimal.parse(
                Decimal.parse(relatorio['total_venda_rua'].toString())
                    .toStringAsFixed(2));
        final numeroVendaFiado = relatorio['numero_venda_fiado'] ?? 0;
        final totalVendaFiado = relatorio['total_venda_fiado'] == null
            ? Decimal.zero
            : Decimal.parse(
                Decimal.parse(relatorio['total_venda_fiado'].toString())
                    .toStringAsFixed(2));
        final totalRecebidoVendaFiado = relatorio['total_pago_venda_fiado'] ==
                null
            ? Decimal.zero
            : Decimal.parse(
                Decimal.parse(relatorio['total_pago_venda_fiado'].toString())
                    .toStringAsFixed(2));
        final totalAReceberVendaFiado =
            relatorio['total_a_receber_venda_fiado'] == null
                ? Decimal.zero
                : Decimal.parse(Decimal.parse(
                        relatorio['total_a_receber_venda_fiado'].toString())
                    .toStringAsFixed(2));

        state = state.copyWith(
          carregando: false,
          pesoTotal: pesoTotal,
          pesoTotalVendido: pesoTotalVendido,
          numeroDeVendas: numeroDeVendas,
          totalDasVendas: totalDasVendas,
          numeroDeVendaRua: numeroVendaRua,
          totalVendaRua: totalVendaRua,
          numeroDeVendaFiado: numeroVendaFiado,
          totalVendaFiado: totalVendaFiado,
          totalRecebidoVendaFiado: totalRecebidoVendaFiado,
          totalAReceberVendaFiado: totalAReceberVendaFiado,
          vendas: vendas,
        );
      } else {
        debugPrint('F');
      }
    } catch (e) {
      // state = state.copyWith(carregando: false);
      debugPrint(e.toString());
    }
  }

  void limparDados() {
    state = state.copyWith(
      // abatimentosDaVenda: const [],
      carregando: false,
    );
  }
}
