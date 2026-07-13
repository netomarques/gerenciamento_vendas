import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';

class BarcoNotifier extends Notifier<BarcoState> {
  BarcoService get _barcoService => ref.read(barcoServiceProvider);

  final int _idBarco;

  BarcoNotifier(this._idBarco);

  @override
  BarcoState build() => const BarcoState.initial(carregando: true);

  Future<void> getBarcoRelatorio() async {
    final List<Viagem> viagens;
    final Barco barco;
    try {
      state = state.copyWith(carregando: true);
      barco = await _barcoService.getBarco(_idBarco);
      viagens = await _barcoService.getViagensPorBarco(_idBarco);
      final relatorio = await _barcoService.getBarcoRelatorio(_idBarco);
      if (relatorio.isNotEmpty) {
        final pesoTotal = _toDecimal(relatorio['peso_total']);
        final pesoTotalVendido = _toDecimal(relatorio['peso_total_vendido']);
        final numeroDeVendas = relatorio['numero_de_vendas'] ?? 0;
        final totalDasVendas = _toDecimal(relatorio['total_das_vendas']);
        final numeroVendaRua = relatorio['numero_venda_rua'] ?? 0;
        final totalVendaRua = _toDecimal(relatorio['total_venda_rua']);
        final numeroVendaFiado = relatorio['numero_venda_fiado'] ?? 0;
        final totalVendaFiado = _toDecimal(relatorio['total_venda_fiado']);
        final totalRecebidoVendaFiado =
            _toDecimal(relatorio['total_pago_venda_fiado']);
        final totalAReceberVendaFiado =
            _toDecimal(relatorio['total_a_receber_venda_fiado']);

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
      debugPrint("ERROR_BARCO_NOTIFIER: ${e.toString()}");
    }
  }

  Decimal _toDecimal(dynamic value) {
    if (value == null) return Decimal.zero;

    return Decimal.parse(
      Decimal.parse(value.toString()).toStringAsFixed(2),
    );
  }
}
