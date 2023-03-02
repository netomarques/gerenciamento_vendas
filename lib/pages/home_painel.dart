import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/model/vendas.dart';
import 'package:vendas_gerenciamento/utils/nav.dart';
import 'package:vendas_gerenciamento/widgets/date_button.dart';
import 'package:vendas_gerenciamento/widgets/nav_buttons_floating.dart';
import 'package:intl/intl.dart';

class HomePainel extends StatefulWidget {
  const HomePainel({super.key});

  @override
  State<HomePainel> createState() => _HomePainelState();
}

class _HomePainelState extends State<HomePainel> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  final DateTime _now = DateTime.now();
  late final TextEditingController _dateStartController =
      TextEditingController(text: _dateFormat.format(_now));
  late final TextEditingController _dateEndController =
      TextEditingController(text: _dateFormat.format(_now));
  Size _size = const Size(0, 0);
  final _vendasStreamController = StreamController<Map<String, Venda>>();
  final _totalStreamController = StreamController<double>();

  @override
  void initState() {
    super.initState();
    String now =_dateFormat.format(_now);
    carregarVendas(now, now);
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: _body(),
    );
  }

  Column _body() {
    return Column(
      children: [
        _painel(),
        _textoInformacao(),
        StreamBuilder<Map<String, Venda>>(
          stream: _vendasStreamController.stream,
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Expanded(
                child: Text('Erro: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final vendas = snapshot.data!;

            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Venda venda = vendas.values.elementAt(index);
                  return _containerVenda(
                      venda.data, venda.quantidade, venda.preco);
                },
              ),
            );
          }),
        ),
        const NavButtonsFloating(),
      ],
    );
  }

  _painel() {
    return Container(
      width: _size.width,
      height: _size.height * 0.25,
      color: const Color(0xff910029),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _painelResumo(),
          _painelDados(),
        ],
      ),
    );
  }

  _painelResumo() {
    return SizedBox(
      width: _size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _painelTotal(),
          _painelFiltroData(),
        ],
      ),
    );
  }

  _painelTotal() {
    return SizedBox(
      width: _size.width * 0.5,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              'Resumo das vendas',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: StreamBuilder<double>(
              stream: _totalStreamController.stream,
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return const Text(
                    'Erro:',
                    style: TextStyle(color: Colors.white, fontSize: 2),
                  );
                }

                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return Text(
                  snapshot.data!.toStringAsFixed(2),
                  style: const TextStyle(color: Colors.white, fontSize: 32),
                );
              }),
            ),
            // child: Text(
            //   'R\$ ${_somaTotal.toStringAsFixed(2)}',
            //   style: const TextStyle(color: Colors.white, fontSize: 32),
            // ),
          ),
        ],
      ),
    );
  }

  _painelFiltroData() {
    return Container(
      width: _size.width * 0.35,
      alignment: Alignment.topCenter,
      child: DateButton(
          _dateStartController.text, _dateEndController.text, carregarVendas),
    );
  }

  _painelDados() {
    return SizedBox(
      width: _size.width,
      child: Row(
        children: <Widget>[
          _painelDadosIcon(),
          _painelDadosValorQuantidade(),
        ],
      ),
    );
  }

  _painelDadosIcon() {
    return SizedBox(
      width: _size.width * 0.4,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: _size.width * 0.4 * 0.3,
            child: Image.asset(
              "assets/images/financial_graphic_icon.png",
              height: _size.height * 0.03,
            ),
          ),
          SizedBox(
            width: _size.width * 0.4 * 0.7,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text(
                    '04',
                    style: TextStyle(color: Color(0xfffdffff), fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 8),
                  child: const Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Total de vendas',
                      style: TextStyle(color: Color(0xfffdffff), fontSize: 12),
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

  _painelDadosValorQuantidade() {
    return SizedBox(
      width: _size.width * 0.6,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: _size.width * 0.6 * 0.5,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'R\$ 21690,00',
                    style: TextStyle(color: Color(0xfffdffff), fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Opacity(
                    opacity: 0.5,
                    child: Text(
                      '02 Rua',
                      style: TextStyle(color: Color(0xfffdffff), fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: _size.width * 0.6 * 0.5,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'R\$ 36000,00',
                    style: TextStyle(color: Color(0xfffdffff), fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Opacity(
                    opacity: 0.5,
                    child: Text(
                      '02 Fiados',
                      style: TextStyle(color: Color(0xfffdffff), fontSize: 12),
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

  _textoInformacao() {
    return Container(
      width: _size.width,
      color: const Color(0xff3B7554),
      padding: const EdgeInsets.all(3.0),
      child: const Opacity(
        opacity: 0.65,
        child: Text(
          textAlign: TextAlign.center,
          'Painel de controle',
          style: TextStyle(color: Color(0xffFDFFFF), fontSize: 20),
        ),
      ),
    );
  }

  _containerVenda(data, quantidade, preco) {
    return GestureDetector(
      onTap: () => {pushNamed(context, "/lista_pagamento")},
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
        width: _size.width,
        height: _size.height * 0.155,
        color: const Color(0xFF006940),
        child: Row(
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _vendaData(data),
                  _vendaQuantidadePrecoPorKG(quantidade, preco),
                ]),
            _vendaValorTotal(quantidade * preco),
          ],
        ),
      ),
    );
  }

  _vendaData(data) {
    return Container(
      width: _size.width * 0.26,
      height: _size.height * 0.03,
      margin: const EdgeInsets.only(left: 8, top: 8),
      decoration: BoxDecoration(
        color: const Color(0xffFDFFFF),
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
      width: _size.width * 0.5,
      height: 61,
      margin: const EdgeInsets.only(left: 8, top: 8),
      child: Row(children: <Widget>[
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
                    color: Color(0xffffffff),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    'Preço/kg: ',
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ]),
        ),
        Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '${quantidade.toString()} Kg',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xfffdffff),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    'R\$ ${preco.toString()}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xfffdffff),
                    ),
                  ),
                ),
              ]),
        ),
      ]),
    );
  }

  _vendaValorTotal(total) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.only(top: 8),
        alignment: Alignment.topRight,
        child: Text(
          "R\$ ${total.toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  void carregarVendas(String dateStart, String dateEnd) {
    _dateStartController.text = dateStart;
    _dateEndController.text = dateEnd;
    
    Map<String, Venda> vendasFiltradas =
        ordenarListaPorDataDecrescente(_dateFormat.parse(dateStart), _dateFormat.parse(dateEnd));
    _vendasStreamController.add(vendasFiltradas);

    double totalVendas = calcularTotal(vendasFiltradas);
    _totalStreamController.add(totalVendas);
  }

  @override
  void dispose() {
    _vendasStreamController.close();
    _totalStreamController.close();
    _dateStartController.dispose();
    _dateEndController.dispose();
    super.dispose();
  }
}
