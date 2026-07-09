import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/providers/states/barco_state.dart';
import 'package:vendas_gerenciamento/services/service.dart';

class BarcoNotifier extends StateNotifier<BarcoState> {
  final BarcoService _barcoService;

  BarcoNotifier(this._barcoService, int idBarco)
      : super(const BarcoState.initial()) {
    getBarcoRelatorio(idBarco);
  }

  void getBarcoRelatorio(int idBarco) async {
    final List<Viagem> viagens;
    final Barco barco;
    try {
      state = state.copyWith(carregando: true);
      barco = await _barcoService.getBarco(idBarco);
      viagens = await _barcoService.getViagensPorBarco(idBarco);
      final relatorio = await _barcoService.getBarcoRelatorio(idBarco);
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
        final totalRecebidoVendaFiado = relatorio['total_pago_venda_fiado'] == null
            ? Decimal.zero
            : Decimal.parse(Decimal.parse(
                    relatorio['total_pago_venda_fiado'].toString())
                .toStringAsFixed(2));
        final totalAReceberVendaFiado = relatorio['total_a_receber_venda_fiado'] == null
            ? Decimal.zero
            : Decimal.parse(Decimal.parse(
                    relatorio['total_a_receber_venda_fiado'].toString())
                .toStringAsFixed(2));

        state = state.copyWith(
          carregando: false,
          barco: barco,
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
          viagens: viagens,
        );
      } else {
        state = state.copyWith(carregando: false);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
