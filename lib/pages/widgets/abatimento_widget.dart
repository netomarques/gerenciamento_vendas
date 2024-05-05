import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/abatimento.dart';
import 'package:intl/intl.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';

class AbatimentoWidget extends StatelessWidget {
  final Abatimento abatimento;

  const AbatimentoWidget({
    super.key,
    required this.abatimento,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd/MM/yy');
    Size deviceSize = context.devicesize;

    return GestureDetector(
      onTap: () => {},
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
        width: deviceSize.width,
        height: deviceSize.height * 0.155,
        color: const Color(0xFF006940),
        child: Column(
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
                  dateFormat.format(abatimento.dateAbatimento),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF969CAF),
                  ),
                ),
              ),
            ),
            Container(
              width: deviceSize.width * 0.6,
              height: deviceSize.height * 0.095,
              margin: const EdgeInsets.only(left: 16, top: 8),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/images/save_money_icon.png",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 8),
                    child: Text(
                      "R\$ ${abatimento.valor.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFFFDFFFF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
