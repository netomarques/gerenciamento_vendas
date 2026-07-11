import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:vendas_gerenciamento/utils/helpers.dart';

class ViagemNotifier extends Notifier<ViagemRelatorioState> {
  ViagemService get _viagemService => ref.read(viagemServiceProvider);
  VendaService get _vendaService => ref.read(vendaServiceProvider);

  final Viagem _viagem;

  ViagemNotifier(this._viagem);

  @override
  ViagemRelatorioState build() =>
      const ViagemRelatorioState.initial().copyWith(viagem: _viagem);

  Future<void> getViagem() async {
    try {
      state = state.copyWith(carregando: true);

      final vendas = await _vendaService.getVendasPorViagemLazyLoading(
        _viagem.id,
        10,
        0,
        Helpers.formatarDateTimeToDateDB(DateTime(1900)),
        Helpers.formatarDateTimeToDateDB(DateTime.now()),
      );
      
      final relatorio = await _viagemService.getViagemRelatorio(_viagem.id);
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

  Decimal _toDecimal(dynamic value) {
    if (value == null) return Decimal.zero;

    return Decimal.parse(
      Decimal.parse(value.toString()).toStringAsFixed(2),
    );
  }

  void limparDados() {
    state = state.copyWith(
      // abatimentosDaVenda: const [],
      carregando: false,
    );
  }
}
