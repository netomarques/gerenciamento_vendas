import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';
import 'package:intl/intl.dart';

class VendaWidget extends StatelessWidget {
  final Venda venda;

  const VendaWidget({
    super.key,
    required this.venda,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd/MM/yy');
    Size deviceSize = context.devicesize;
    Color cor = venda.fiado == false || venda.isAberto == false
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
                      dateFormat.format(venda.date),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF969CAF),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: deviceSize.width * 0.5,
                  height: deviceSize.height * 0.078,
                  margin: const EdgeInsets.only(left: 8, top: 8),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/checkout_price_icon.png",
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Quant: ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFDFFFF),
                              ),
                            ),
                            Opacity(
                              opacity: 0.6,
                              child: Text(
                                'Preço/kg: ',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Color(0xFFFDFFFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              '${venda.quantidade.toStringAsFixed(2)} Kg',
                              style: TextStyle(
                                fontSize: (deviceSize.width *
                                        0.5 *
                                        deviceSize.height *
                                        0.078 *
                                        0.095) /
                                    100,
                                color: const Color(0xFFFDFFFF),
                              ),
                            ),
                            Opacity(
                              opacity: 0.6,
                              child: Text(
                                'R\$ ${venda.preco.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: (deviceSize.width *
                                          0.5 *
                                          deviceSize.height *
                                          0.078 *
                                          0.09) /
                                      100,
                                  color: const Color(0xFFFDFFFF),
                                ),
                              ),
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
                        "R\$ ${venda.total?.toStringAsFixed(2)}",
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
                    venda.cliente.nome,
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
}
