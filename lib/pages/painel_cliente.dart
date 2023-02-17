import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/nav.dart';

class PainelCliente extends StatefulWidget {
  const PainelCliente({super.key});

  @override
  State<PainelCliente> createState() => _PainelClienteState();
}

class _PainelClienteState extends State<PainelCliente> {
  Size _size = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

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
        Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.5,
              child: Container(
                height: _size.height * 0.075,
                margin: const EdgeInsets.only(
                    left: 16, top: 20, right: 32, bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF006940),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
            _containerText(),
          ],
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _containerVenda();
            },
            itemCount: 7,
          ),
        )
      ],
    );
  }

  _head() {
    return Stack(
      children: <Widget>[
        Container(
          width: _size.width,
          height: _size.height * 0.23,
          color: const Color(0xFF910029),
          child: Column(
            children: <Widget>[
              Container(
                color: const Color(0xFF006940),
                width: _size.width,
                height: _size.height * 0.075,
              ),
              Container(
                height: _size.height * 0.085,
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Text(
                      "Jose Costa Larga",
                      style: TextStyle(color: Color(0xffFDFFFF), fontSize: 16),
                    ),
                    Text(
                      "92991235963",
                      style: TextStyle(
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
          margin: EdgeInsets.only(top: 8, left: _size.width * 0.40),
          child: Image.asset(
            "assets/images/client_avatar_icon.png",
            height: _size.height * 0.1,
          ),
        ),
      ],
    );
  }

  _containerText() {
    return Container(
      height: _size.height * 0.076,
      margin: const EdgeInsets.only(left: 16, top: 20, right: 32, bottom: 16),
      child: _textForm("Data", "Informe a data"),
    );
  }

  _textForm(labelText, hintText) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF006940).withOpacity(0.5),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF910029),
        ),
        decoration: InputDecoration(
          icon: Image.asset(
            "assets/images/find_search_icon.png",
            height: _size.height * 0.05,
          ),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 14, color: Color(0xFF006940)),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xff910029),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  _textoInformacao() {
    return Container(
      width: _size.width,
      height: _size.height * 0.07,
      color: const Color(0xff3B7554),
      padding: const EdgeInsets.all(3.0),
      child: const Opacity(
        opacity: 0.65,
        child: Center(
          child: Text(
            "Total a receber: R\$ 3009,00",
            style: TextStyle(color: Color(0xffFDFFFF), fontSize: 20),
          ),
        ),
      ),
    );
  }

  _containerVenda() {
    return GestureDetector(
      onTap: () => pushNamed(context, "/lista_pagamento"),
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
                  _vendaData(),
                  _vendaQuantidadePrecoPorKG(),
                ]),
            _vendaValorTotal(),
          ],
        ),
      ),
    );
  }

  _vendaData() {
    return Container(
      width: _size.width * 0.26,
      height: _size.height * 0.03,
      margin: const EdgeInsets.only(left: 8, top: 8),
      decoration: BoxDecoration(
        color: const Color(0xffFDFFFF),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Text(
        '24 JAN 2023',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff969CAF),
        ),
      ),
    );
  }

  _vendaQuantidadePrecoPorKG() {
    return Container(
      width: _size.width * 0.5,
      height: 61,
      margin: const EdgeInsets.only(left: 8, top: 8),
      child: Row(children: <Widget>[
        Image.asset(
          "assets/images/checkout_price_icon.png",
          height: _size.height * 0.08,
          //color: const Color(0xffEB710A),
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
              children: const <Widget>[
                Text(
                  '80 Kg',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xfffdffff),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    'R\$ 12,00',
                    style: TextStyle(
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

  _vendaValorTotal() {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.only(top: 8),
      alignment: Alignment.topRight,
      child: const Text(
        "R\$ 18000,00",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
