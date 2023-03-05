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
  final _resumoStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  @override
  void initState() {
    super.initState();
    String now = _dateFormat.format(_now);
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
                itemCount: vendas.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Color cor;
                  Venda venda = vendas.values.elementAt(index);
                  venda.isFiado() == false || venda.isOpen() == false
                      ? cor = const Color(0xFF006940)
                      : cor = const Color(0xff910029);
                  return _containerVenda(venda.data, venda.quantidade,
                      venda.preco, cor, venda.cliente.nome);
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
            child: StreamBuilder<Map<String, dynamic>>(
              stream: _resumoStreamController.stream,
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
                  'R\$ ${snapshot.data!["Vendas"]["Total"].toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 32),
                );
              }),
            ),
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
          _painelTotalVendas(),
          _painelDadosValorQuantidade(),
        ],
      ),
    );
  }

  _painelTotalVendas() {
    return SizedBox(
      width: _size.width * 0.4,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: _size.width * 0.4 * 0.3,
            child: Image.asset(
              "assets/images/financial_graphic_icon.png",
              height: _size.height * 0.05,
            ),
          ),
          SizedBox(
            width: _size.width * 0.4 * 0.7,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 8),
                  child: StreamBuilder<Map<String, dynamic>>(
                    stream: _resumoStreamController.stream,
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
                        snapshot.data!["Vendas"]["Quantidade"]
                            .toString()
                            .padLeft(2, '0'),
                        style: const TextStyle(
                            color: Color(0xfffdffff), fontSize: 16),
                      );
                    }),
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
      child: StreamBuilder<Map<String, dynamic>>(
        stream: _resumoStreamController.stream,
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

          return Row(
            children: <Widget>[
              SizedBox(
                width: _size.width * 0.6 * 0.5,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'R\$ ${snapshot.data!["Rua"]["Total"].toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Color(0xfffdffff), fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Opacity(
                        opacity: 0.5,
                        child: Text(
                          '${snapshot.data!["Rua"]["Quantidade"].toString().padLeft(2, '0')} Rua',
                          style: const TextStyle(
                              color: Color(0xfffdffff), fontSize: 12),
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
                      child: Text(
                        'R\$ ${snapshot.data!["Fiado"]["Total"].toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Color(0xfffdffff), fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Opacity(
                        opacity: 0.5,
                        child: Text(
                          '${snapshot.data!["Fiado"]["Quantidade"].toString().padLeft(2, '0')} Fiados',
                          style: const TextStyle(
                              color: Color(0xfffdffff), fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
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

  _containerVenda(data, quantidade, preco, cor, cliente) {
    return GestureDetector(
      onTap: () => {pushNamed(context, "/lista_pagamento")},
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
        width: _size.width,
        height: _size.height * 0.155,
        color: cor,
        child: Row(
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _vendaData(data),
                  _vendaQuantidadePrecoPorKG(quantidade, preco),
                ]),
            _vendaValorTotal(quantidade * preco, cliente),
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

  void carregarVendas(String dateStart, String dateEnd) async {
    _dateStartController.text = dateStart;
    _dateEndController.text = dateEnd;

    Map<String, Venda> vendasFiltradas = await ordenarListaPorDataDecrescente(
        _dateFormat.parse(dateStart), _dateFormat.parse(dateEnd));
    Map<String, dynamic> resumo = await resumoVendas(vendasFiltradas);

    _vendasStreamController.add(vendasFiltradas);
    _resumoStreamController.add(resumo);
  }

  @override
  void dispose() {
    _vendasStreamController.close();
    _resumoStreamController.close();
    _dateStartController.dispose();
    _dateEndController.dispose();
    super.dispose();
  }
}
