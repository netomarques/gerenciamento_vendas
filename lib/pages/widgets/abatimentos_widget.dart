import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/abatimento.dart';
import 'package:intl/intl.dart';

class AbatimentosWidget extends StatelessWidget {
  final List<Abatimento> _abatimentosVenda;

  AbatimentosWidget(this._abatimentosVenda, {super.key});

  final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  double _altura = 0.0;
  double _largura = 0.0;

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;

    return Expanded(
        child: ListView.builder(
      itemCount: _abatimentosVenda.length,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        Abatimento abatimento = _abatimentosVenda[index];

        return GestureDetector(
          onTap: () => {},
          child: Container(
            margin:
                const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
            width: _largura,
            height: _altura * 0.155,
            color: const Color(0xFF006940),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _abatimentoData(abatimento.dateAbatimento),
                _abatimentoValor(abatimento.valor),
              ],
            ),
          ),
        );
      }),
    ));
  }

  _abatimentoData(data) {
    return Container(
      width: _largura * 0.26,
      height: _altura * 0.03,
      margin: const EdgeInsets.only(left: 8, top: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFFFF),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          _dateFormat.format(data),
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF969CAF),
          ),
        ),
      ),
    );
  }

  _abatimentoValor(valor) {
    return Container(
      width: _largura * 0.6,
      height: _altura * 0.095,
      margin: const EdgeInsets.only(left: 16, top: 8),
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/images/save_money_icon.png",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              "R\$ ${valor.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFFDFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
