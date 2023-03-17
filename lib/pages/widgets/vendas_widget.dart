import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/utils/nav.dart';
import 'package:intl/intl.dart';

class VendasWidget extends StatelessWidget {
  final List<Venda> _vendas;
  final String _route;

  VendasWidget(this._vendas, this._route, {super.key});

  final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  double _altura = 0.0;
  double _largura = 0.0;

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;

    return Expanded(
      child: ListView.builder(
        itemCount: _vendas.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Color cor;
          Venda venda = _vendas[index];
          venda.isFiado() == false || venda.isOpen() == false
              ? cor = const Color(0xFF006940)
              : cor = const Color(0xFF910029);
          return GestureDetector(
            onTap: () => pushNamed(
              context,
              _route,
              arguments: {"venda": venda},
            ),
            child: Container(
              margin:
                  const EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
              width: _largura,
              height: _altura * 0.155,
              color: cor,
              child: Row(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _vendaData(venda.data),
                        _vendaQuantidadePrecoPorKG(
                            venda.quantidade, venda.preco),
                      ]),
                  _vendaValorTotal(venda.total(), venda.cliente.nome),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _vendaData(data) {
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

  _vendaQuantidadePrecoPorKG(quantidade, preco) {
    return Container(
      width: _largura * 0.5,
      height: 61,
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
              children: const <Widget>[
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
                  '${quantidade.toStringAsFixed(2)} Kg',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFDFFFF),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    'R\$ ${preco.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFDFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _vendaValorTotal(total, cliente) {
    return Expanded(
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
                  style: TextStyle(color: Color(0xFFFDFFFF), fontSize: 12),
                ),
                Text(
                  "R\$ ${total.toStringAsFixed(2)}",
                  style:
                      const TextStyle(color: Color(0xFFFDFFFF), fontSize: 24),
                ),
              ],
            ),
            Text(
              cliente,
              style: const TextStyle(color: Color(0xFFFDFFFF), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
