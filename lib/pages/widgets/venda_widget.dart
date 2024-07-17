import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendaWidget extends ConsumerWidget {
  final Venda venda;

  const VendaWidget({
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
      height: deviceSize.height * 0.155,
      color: cor,
      child: Row(
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: deviceSize.width * 0.26,
                  height: deviceSize.height * 0.03,
                  margin: const EdgeInsets.only(left: 8, top: 8),
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
                Container(
                  width: deviceSize.width * 0.5,
                  height: deviceSize.height * 0.09,
                  margin: const EdgeInsets.only(left: 8, top: 8),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/checkout_price_icon.png",
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _textCampo('Quant '),
                            _textCampo('Preço/kg: '),
                            _textCampo('Desconto: '),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _textValor(
                              'Kg ${vendaState.venda!.quantidade.toStringAsFixed(2)}',
                              deviceSize,
                            ),
                            _textValor(
                              'R\$ ${vendaState.venda!.preco.toStringAsFixed(2)}',
                              deviceSize,
                            ),
                            _textValor(
                              'R\$ ${vendaState.venda!.desconto.toStringAsFixed(2)}',
                              deviceSize,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 6, top: 8),
              alignment: Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Total",
                        style:
                            TextStyle(color: Color(0xFFFDFFFF), fontSize: 12),
                      ),
                      Text(
                        "R\$ ${vendaState.venda!.total?.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: const Color(0xFFFDFFFF),
                          fontSize: (deviceSize.width *
                                  0.5 *
                                  deviceSize.height *
                                  0.078 *
                                  0.15) /
                              100,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    vendaState.venda!.cliente.nome,
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

  _textCampo(text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xFFFDFFFF),
      ),
    );
  }

  _textValor(text, deviceSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize:
            (deviceSize.width * 0.5 * deviceSize.height * 0.078 * 0.095) / 100,
        color: const Color(0xFFFDFFFF),
      ),
    );
  }
}
