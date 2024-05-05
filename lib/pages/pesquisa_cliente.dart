import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';
import 'package:vendas_gerenciamento/utils/nav.dart';
import 'package:vendas_gerenciamento/widgets/nav_buttons_floating.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PesquisaCliente extends ConsumerStatefulWidget {
  static PesquisaCliente builder(BuildContext context, GoRouterState state) =>
      const PesquisaCliente();

  const PesquisaCliente({super.key});

  @override
  ConsumerState<PesquisaCliente> createState() => _PesquisaClienteState();
}

class _PesquisaClienteState extends ConsumerState<PesquisaCliente> {
  late final StreamController<List<Cliente>> _clientesStreamController;
  late final List<Cliente> _clientes;
  late Size _deviceSize;
  late ClienteState _clienteState;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _clienteState = ref.watch(clienteProvider);
    _carregarClientes();

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
                  itemCount: snapshot.data!.length,
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
      width: _deviceSize.width,
      height: _deviceSize.height * 0.1,
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
      height: _deviceSize.height * 0.08,
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
      child: TextField(
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF910029),
        ),
        onChanged: _pesquisarClientesPorNome,
        decoration: InputDecoration(
          icon: Image.asset(
            "assets/images/find_search_icon.png",
            height: _deviceSize.height * 0.05,
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
      height: _deviceSize.height * 0.1,
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

  void _pesquisarClientesPorNome(String nome) {
    List<Cliente> clientesFiltrados = _clientes
        .where((cliente) =>
            cliente.nome.toLowerCase().startsWith(nome.toLowerCase()))
        .toList();
    _clientesStreamController.add(clientesFiltrados);
  }

  void _carregarClientes() {
    final clientes = _clienteState.list;
    _clientesStreamController.add(
      List.generate(
        clientes.length,
        (index) => Cliente.fromJson(clientes[index]),
      ),
    );
  }

  void _carregarDados() {
    _clientesStreamController = StreamController<List<Cliente>>();
    _clientesStreamController.add(_clientes = []);
  }

  @override
  void dispose() {
    _clientesStreamController.close();
    super.dispose();
  }
}
