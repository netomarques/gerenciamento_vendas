import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class VendaWidget extends ConsumerWidget {
  final Venda venda;
  final NumberFormat _formatterMoeda =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  final NumberFormat _formatterQuantidade = NumberFormat('#,##0.00', 'pt_BR');

  VendaWidget({
    super.key,
    required this.venda,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendaState = ref.watch(vendaProvider(venda));
    Size deviceSize = context.devicesize;
    Color cor =
        vendaState.venda!.fiado == false || vendaState.venda!.isAberto == false
            ? const Color(0xFF006940)
            : const Color(0xFF910029);

    return Container(
      margin: const EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
      width: deviceSize.width,
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: deviceSize.width * 0.26,
                  margin: const EdgeInsets.only(left: 8, top: 8),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      Helpers.formatarDateTimeToString(vendaState.venda!.date),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF969CAF),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Image.asset(
                            "assets/images/checkout_price_icon.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _linhaInfo(
                                'Peso:',
                                '${_formatterQuantidade.format(vendaState.venda!.quantidade.toDouble())} kg',
                              ),
                              const SizedBox(height: 4),
                              _linhaInfo(
                                'Preço/kg:',
                                _formatterMoeda
                                    .format(vendaState.venda!.preco.toDouble()),
                              ),
                              const SizedBox(height: 4),
                              _linhaInfo(
                                'Desconto:',
                                _formatterMoeda.format(
                                    vendaState.venda!.desconto.toDouble()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 6, top: 8, bottom: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Total",
                        style:
                            TextStyle(color: Color(0xFFFDFFFF), fontSize: 12),
                      ),
                      Text(
                        _formatterMoeda
                            .format(vendaState.venda!.total!.toDouble()),
                        style: const TextStyle(
                          color: Color(0xFFFDFFFF),
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    vendaState.venda!.cliente.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color(0xFFFDFFFF), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _linhaInfo(String rotulo, String valor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text(
          rotulo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFFDFFFF),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            valor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFFDFFFF),
            ),
          ),
        ),
      ],
    );
  }
}
