import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';

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
          ClientesWidget(
            clientes: _clientesState.list,
            route: RouteLocation.painelCliente,
            scrollController: _scrollController,
            onRefresh: _refresh,
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
