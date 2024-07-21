import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:vendas_gerenciamento/widgets/date_button.dart';
import 'package:vendas_gerenciamento/widgets/nav_buttons_floating.dart';

class HomePainel extends ConsumerStatefulWidget {
  static HomePainel builder(BuildContext context, GoRouterState state) =>
      const HomePainel();
  const HomePainel({super.key});

  @override
  ConsumerState<HomePainel> createState() => _HomePainelState();
}

class _HomePainelState extends ConsumerState<HomePainel> {
  late final ScrollController _scrollController;
  late Size _deviceSize;
  late ListaVendasState _vendasState;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _vendasState = ref.watch(listaVendasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.dashboard,
              color: Color(0xFFEB710A),
            ),
            onPressed: () {
              ref.read(connectionProvider).exportDatabase();
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  Column _body() {
    return Column(
      children: [
        _painel(),
        _textoInformacao(),
        VendasWidget(
          route: RouteLocation.listarPagamentos,
          vendas: _vendasState.list,
          scrollController: _scrollController,
        ),
        _vendasState.carregando
            ? const Center(child: CircularProgressIndicator())
            : Container(),
        NavButtonsFloating(),
      ],
    );
  }

  _painel() {
    return Container(
      width: _deviceSize.width,
      height: _deviceSize.height * 0.25,
      color: const Color(0xFFEB710A),
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
      width: _deviceSize.width,
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
      width: _deviceSize.width * 0.5,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              'Resumo das vendas',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          _vendasState.carregando
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'R\$ ${_vendasState.totalDasVendas}',
                    style: const TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ),
        ],
      ),
    );
  }

  _painelFiltroData() {
    return Container(
      width: _deviceSize.width * 0.35,
      alignment: Alignment.topCenter,
      child: DateButton(
          Helpers.formatarDateTimeToString(DateTime.now()),
          Helpers.formatarDateTimeToString(DateTime.now()),
          pesquisarVendasPorData),
    );
  }

  _painelDados() {
    return SizedBox(
      width: _deviceSize.width,
      child: _vendasState.carregando
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: <Widget>[
                _painelTotalVendas(),
                _painelDadosValorQuantidade(),
              ],
            ),
    );
  }

  _painelTotalVendas() {
    return SizedBox(
      width: _deviceSize.width * 0.4,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: _deviceSize.width * 0.4 * 0.3,
            child: Image.asset(
              "assets/images/financial_graphic_icon.png",
              height: _deviceSize.height * 0.05,
            ),
          ),
          SizedBox(
            width: _deviceSize.width * 0.4 * 0.7,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 8),
                  child: _text(
                      _vendasState.list.length.toString().padLeft(2, '0'), 16),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 8),
                  child: Opacity(
                    opacity: 0.5,
                    child: _text('Total de vendas', 12),
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
      width: _deviceSize.width * 0.6,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: _deviceSize.width * 0.6 * 0.5,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: _text('R\$ ${_vendasState.totalDaVendaRua}', 16),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Opacity(
                    opacity: 0.5,
                    child: _text(
                        '${_vendasState.qtdeVendaRua.toString().padLeft(2, '0')} Rua',
                        12),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: _deviceSize.width * 0.6 * 0.5,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: _text('R\$ ${_vendasState.totalDaVendaFiado}', 16),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Opacity(
                    opacity: 0.5,
                    child: _text(
                        '${_vendasState.qtdeVendaFiado.toString().padLeft(2, '0')} Fiados',
                        12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _text(text, double fontSize) {
    return Text(
      text,
      style: TextStyle(color: const Color(0xFFFDFFFF), fontSize: fontSize),
    );
  }

  _textoInformacao() {
    return Container(
      width: _deviceSize.width,
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

  void pesquisarVendasPorData(String startDate, String endDate) {
    ref.read(listaVendasProvider.notifier).getVendasPorData(
          Helpers.stringFormatadaToDateTime(startDate),
          Helpers.stringFormatadaToDateTime(endDate),
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_vendasState.carregando) {
      ref
          .read(listaVendasProvider.notifier)
          .getVendasLazyLoading(carregarMaisVendas: true);
    }
  }

  void _carregarDados() async {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
