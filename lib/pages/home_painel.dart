import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/api/vendas_api.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/pages/widgets/vendas_widget.dart';
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
  late final TextEditingController _dateStartController;
  late final TextEditingController _dateEndController;
  late final StreamController<List<Venda>> _vendasStreamController;
  late final StreamController<Map<String, dynamic>> _resumoStreamController;
  late final VendasApi vendasApi;
  late double _largura;
  late double _altura;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;

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
        StreamBuilder<List<Venda>>(
          stream: _vendasStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Expanded(
                child: Center(child: Text('Erro: ${snapshot.error}')),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final List<Venda> vendas = snapshot.data!;

            return VendasWidget(vendas, "/lista_pagamento");
          },
        ),
        const NavButtonsFloating(),
      ],
    );
  }

  _painel() {
    return Container(
      width: _largura,
      height: _altura * 0.25,
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
      width: _largura,
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
      width: _largura * 0.5,
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
      width: _largura * 0.35,
      alignment: Alignment.topCenter,
      child: DateButton(
          _dateStartController.text, _dateEndController.text, carregarVendas),
    );
  }

  _painelDados() {
    return SizedBox(
      width: _largura,
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
      width: _largura * 0.4,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: _largura * 0.4 * 0.3,
            child: Image.asset(
              "assets/images/financial_graphic_icon.png",
              height: _altura * 0.05,
            ),
          ),
          SizedBox(
            width: _largura * 0.4 * 0.7,
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
      width: _largura * 0.6,
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
                width: _largura * 0.6 * 0.5,
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
                width: _largura * 0.6 * 0.5,
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
      width: _largura,
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

  void carregarVendas(String dateStart, String dateEnd) async {
    _dateStartController.text = dateStart;
    _dateEndController.text = dateEnd;

    List<Venda> vendasFiltradas =
        await vendasApi.ordenarListaPorDataDecrescente(
            _dateFormat.parse(dateStart), _dateFormat.parse(dateEnd));
    Map<String, dynamic> resumo = await vendasApi.resumoVendas(vendasFiltradas);

    _vendasStreamController.add(vendasFiltradas);
    _resumoStreamController.add(resumo);
  }

  void _carregarDados() async {
    vendasApi = VendasApi();

    DateTime now = DateTime.now();
    _dateStartController = TextEditingController(text: _dateFormat.format(now));
    _dateEndController = TextEditingController(text: _dateFormat.format(now));

    _vendasStreamController = StreamController<List<Venda>>();
    _resumoStreamController =
        StreamController<Map<String, dynamic>>.broadcast();

    // DateTime startData = _dateFormat.parse('00/00/0000');
    List<Venda> vendasFiltradas =
        await vendasApi.ordenarListaPorDataDecrescente(
            _dateFormat.parse(_dateFormat.format(now)),
            _dateFormat.parse(_dateFormat.format(now)));

    Map<String, dynamic> resumo = await vendasApi.resumoVendas(vendasFiltradas);

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
