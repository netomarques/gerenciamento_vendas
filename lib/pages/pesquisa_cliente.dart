import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';
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
  late Size _deviceSize;
  late ClientesState _clientesState;
  late final ScrollController _scrollController;
  late TextEditingController _textPesquisarPorNomeController;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _clientesState = ref.watch(clientesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB710A),
        title: const Text(
          'Clientes',
          style: TextStyle(
            color: Color(0xffFDFFFF),
            fontSize: 30,
          ),
        ),
      ),
      // resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  _body() {
    return Container(
      color: const Color(0xFF006940),
      child: Column(
        children: <Widget>[
          _containerTextPesquisa(),
          Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: const Divider(color: Color(0xFFEB710A), thickness: 1)),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Cliente cliente = _clientesState.list[index];
                  ClienteAtualState clienteAtualState =
                      ref.watch(clienteAtualProvider(cliente.id!));

                  return GestureDetector(
                    child: _containerCliente(clienteAtualState.cliente!.nome,
                        clienteAtualState.cliente!.telefone),
                    onTap: () {
                      ref
                          .read(clienteAtualProvider(
                                  clienteAtualState.cliente!.id!)
                              .notifier)
                          .getVendasPorClienteLazyLoading();
                      context.push(RouteLocation.painelCliente,
                          extra: cliente.id!);
                    },
                  );
                },
                itemCount: _clientesState.list.length,
              ),
            ),
          ),
          _clientesState.carregando
              ? const Center(child: CircularProgressIndicator())
              : Container(),
          // NavButtonsFloating(),
        ],
      ),
    );
  }

  _containerTextPesquisa() {
    return Container(
      height: _deviceSize.height * 0.08,
      margin: const EdgeInsets.only(left: 16, top: 20, right: 32, bottom: 16),
      child: _textPesquisaClientePorNomeForm(),
    );
  }

  _textPesquisaClientePorNomeForm() {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFFFF),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        controller: _textPesquisarPorNomeController,
        style: const TextStyle(
          fontSize: 14,
          // color: Color(0xFF910029),
        ),
        onChanged: _pesquisarClientesPorNome,
        decoration: InputDecoration(
          icon: Image.asset(
            "assets/images/find_search_icon.png",
            height: _deviceSize.height * 0.05,
          ),
          labelText: 'Nome',
          labelStyle: const TextStyle(fontSize: 14, color: Color(0xFF006940)),
          hintText: 'Informe o nome do cliente',
          hintStyle: const TextStyle(
            fontSize: 14,
            // color: Color(0xFF910029),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  _containerCliente(String nome, String telefone) {
    return Container(
      color: const Color(0xFFEB710A),
      height: _deviceSize.height * 0.1,
      margin: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            nome,
            style: const TextStyle(
              color: Color(0xffFDFFFF),
              fontSize: 16,
            ),
          ),
          Text(
            // telefone,
            formatarTelefone(telefone),
            style: const TextStyle(
              color: Color(0xffFDFFFF),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  String formatarTelefone(String telefone) {
    final telefoneFormatado = StringBuffer();

    telefoneFormatado.write('(${telefone.substring(0, 2)}) ');

    if (telefone.length == 11) {
      telefoneFormatado.write('${telefone.substring(2, 7)}-');
      telefoneFormatado.write(telefone.substring(7));
    } else {
      telefoneFormatado.write('${telefone.substring(2, 6)}-');
      telefoneFormatado.write(telefone.substring(6));
    }

    return telefoneFormatado.toString();
  }

  void _pesquisarClientesPorNome(String nome) {
    if (!_clientesState.carregando) {
      if (nome.isNotEmpty) {
        ref
            .read(clientesProvider.notifier)
            .getClientesFiltradosLazyLoading(nome);
      } else {
        ref.read(clientesProvider.notifier).getClientesLazyLoading();
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_clientesState.carregando) {
      if (!_clientesState.filtroPorNome) {
        ref.read(clientesProvider.notifier).carregarMaisClientesLazyLoading();
      } else {
        ref.read(clientesProvider.notifier).getClientesFiltradosLazyLoading(
              _textPesquisarPorNomeController.text,
              carregarMais: true,
            );
      }
    }
  }

  Future<void> _refresh() async {
    if (!_clientesState.carregando) {
      ref.read(clientesProvider.notifier).getClientesLazyLoading();
    }
  }

  void _carregarDados() {
    _textPesquisarPorNomeController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _textPesquisarPorNomeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
