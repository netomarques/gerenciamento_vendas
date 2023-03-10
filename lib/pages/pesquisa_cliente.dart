import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';
import 'package:vendas_gerenciamento/model/clientes.dart';
import 'package:vendas_gerenciamento/utils/nav.dart';
import 'package:vendas_gerenciamento/widgets/nav_buttons_floating.dart';

class PesquisaCliente extends StatefulWidget {
  const PesquisaCliente({super.key});

  @override
  State<PesquisaCliente> createState() => _PesquisaClienteState();
}

class _PesquisaClienteState extends State<PesquisaCliente> {
  final _clientesStreamController = StreamController<List<Cliente>>();
  late List<Cliente> _clientesCopia;
  double _largura = 0.0;
  double _altura = 0.0;

  @override
  void initState() {
    super.initState();
    _carregarClientes();
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
    return Container(
      color: const Color(0xFF006940),
      child: Column(
        children: <Widget>[
          _tituloForm(),
          _containerText(),
          Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: const Divider(color: Color(0xFF910029), thickness: 1)),
          StreamBuilder<List<Cliente>>(
            stream: _clientesStreamController.stream,
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Cliente cliente = snapshot.data![index];

                    return GestureDetector(
                      child: _containerCliente(cliente.nome, cliente.telefone),
                      onTap: () => pushNamed(
                        context,
                        "/painel_cliente",
                        arguments: {"cliente": cliente},
                      ),
                    );
                  },
                  itemCount: _clientesCopia.length,
                ),
              );
            }),
          ),
          const NavButtonsFloating(),
        ],
      ),
    );
  }

  _tituloForm() {
    return Container(
      width: _largura,
      height: _altura * 0.1,
      color: const Color(0xff910029),
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: const Text(
        'Clientes',
        style: TextStyle(
          color: Color(0xffFDFFFF),
          fontSize: 30,
        ),
      ),
    );
  }

  _containerText() {
    return Container(
      height: _altura * 0.08,
      margin: const EdgeInsets.only(left: 16, top: 20, right: 32, bottom: 16),
      child: _textForm("Nome", "Nome do cliente"),
    );
  }

  _textForm(labelText, hintText) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFFFF),
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
            height: _altura * 0.05,
          ),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 14, color: Color(0xFF006940)),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFF910029),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  _containerCliente(String nome, String telefone) {
    return Container(
      color: const Color(0xFFB6C5DE),
      height: MediaQuery.of(context).size.height * 0.1,
      margin: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            nome,
            style: const TextStyle(
              color: Color(0xFF910029),
              fontSize: 16,
            ),
          ),
          Text(
            telefone,
            style: const TextStyle(
              color: Color(0xFF910029),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _carregarClientes() {
    _clientesCopia = clientes.values.toList();
    _clientesStreamController.add(_clientesCopia);
  }

  @override
  void dispose() {
    _clientesStreamController.close();
    super.dispose();
  }
}
