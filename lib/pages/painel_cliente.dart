import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/api/vendas_api.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/pages/widgets/vendas_widget.dart';
import 'package:vendas_gerenciamento/widgets/date_input_widget.dart';
import 'package:intl/intl.dart';

class PainelCliente extends StatefulWidget {
  final Cliente _cliente;
  const PainelCliente(this._cliente, {super.key});

  @override
  State<PainelCliente> createState() => _PainelClienteState();
}

class _PainelClienteState extends State<PainelCliente> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  final _vendasStreamController = StreamController<List<Venda>>();
  double _altura = 0.0;
  double _largura = 0.0;
  late final Future<double> _totalAReceber;

  @override
  void initState() {
    super.initState();
    _totalAReceber = _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        _head(),
        _textoInformacao(),
        DateInputWidget(_carregarVendas),
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
      ],
    );
  }

  _head() {
    return Stack(
      children: <Widget>[
        Container(
          width: _largura,
          height: _altura * 0.23,
          color: const Color(0xFF910029),
          child: Column(
            children: <Widget>[
              Container(
                color: const Color(0xFF006940),
                width: _largura,
                height: _altura * 0.075,
              ),
              Container(
                height: _altura * 0.085,
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      widget._cliente.nome,
                      style: const TextStyle(
                          color: Color(0xffFDFFFF), fontSize: 16),
                    ),
                    Text(
                      widget._cliente.telefone,
                      style: const TextStyle(
                        color: Color(0xffFDFFFF),
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8, left: _largura * 0.40),
          child: Image.asset(
            "assets/images/client_avatar_icon.png",
            height: _altura * 0.1,
          ),
        ),
      ],
    );
  }

  _textoInformacao() {
    return Container(
      width: _largura,
      height: _altura * 0.07,
      color: const Color(0xff3B7554),
      padding: const EdgeInsets.all(3.0),
      child: Opacity(
        opacity: 0.65,
        child: Center(
          child: FutureBuilder<double>(
            future: _totalAReceber,
            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  "Total a receber: R\$ ${snapshot.data!.toStringAsFixed(2)}",
                  style:
                      const TextStyle(color: Color(0xffFDFFFF), fontSize: 20),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  void _carregarVendas(String dateStart, String dateEnd) async {
    List<Venda> vendasCliente = await VendasApi().vendasCliente(
      widget._cliente.id,
      _dateFormat.parse(dateStart),
      _dateFormat.parse(dateEnd),
    );

    _vendasStreamController.add(vendasCliente);
  }

  Future<double> _carregarDados() async {
    List<Venda> vendasCliente = await VendasApi().vendasCliente(
        widget._cliente.id,
        _dateFormat.parse(_dateFormat.format(DateTime(1900))),
        _dateFormat.parse(_dateFormat.format(DateTime.now())));

    _vendasStreamController.add(vendasCliente);
    return VendasApi().valorTotalEmAbertoPorCliente(vendasCliente);
  }

  @override
  void dispose() {
    _vendasStreamController.close();
    super.dispose();
  }
}
