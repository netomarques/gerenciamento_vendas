import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:vendas_gerenciamento/widgets/date_button.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PainelCliente extends ConsumerStatefulWidget {
  final int idCliente;

  static PainelCliente builder(BuildContext context, GoRouterState state) =>
      PainelCliente(state.extra as int);

  const PainelCliente(this.idCliente, {super.key});

  @override
  ConsumerState<PainelCliente> createState() => _PainelClienteState();
}

class _PainelClienteState extends ConsumerState<PainelCliente> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  late String _dateStart;
  late String _dateEnd;
  late Size _deviceSize;
  late ClienteAtualState _clienteAtualState;
  late final int _idCliente;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  _carregarDados() {
    scrollController = ScrollController();
    scrollController.addListener(_onScrollCarregarMaisVendas);
    _dateStart = _dateFormat.format(DateTime.now());
    _dateEnd = _dateFormat.format(DateTime.now());

    _idCliente = widget.idCliente;
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _clienteAtualState = ref.watch(clienteAtualProvider(_idCliente));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB710A),
        title: const Text(
          'Painel do Cliente',
          style: TextStyle(
            color: Color(0xFFFDFFFF),
          ),
        ),
        leading: BackButton(
          onPressed: () {
            context.pop();
            _limparDados();
          },
        ),
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
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
              width: _deviceSize.width * 0.35,
              child: DateButton(_dateStart, _dateEnd, _carregarVendasPorData)),
        ),
        VendasWidget(
          vendas: _clienteAtualState.vendasDoCliente,
          route: RouteLocation.listarPagamentos,
          scrollController: scrollController,
        ),
        _clienteAtualState.carregando
            ? const CircularProgressIndicator()
            : Container(),
      ],
    );
  }

  _head() {
    return Stack(
      children: <Widget>[
        Container(
          width: _deviceSize.width,
          height: _deviceSize.height * 0.23,
          color: const Color(0xFFEB710A),
          child: Column(
            children: <Widget>[
              Container(
                color: const Color(0xFF006940),
                width: _deviceSize.width,
                height: _deviceSize.height * 0.075,
              ),
              Container(
                height: _deviceSize.height * 0.085,
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      _clienteAtualState.cliente!.nome,
                      style: const TextStyle(
                          color: Color(0xffFDFFFF), fontSize: 16),
                    ),
                    Text(
                      _clienteAtualState.cliente!.telefone,
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
        GestureDetector(
          onTap: () =>
              context.push(RouteLocation.alterarCliente, extra: _idCliente),
          child: Container(
            margin: EdgeInsets.only(top: 8, left: _deviceSize.width * 0.40),
            child: Image.asset(
              "assets/images/client_avatar_icon.png",
              height: _deviceSize.height * 0.1,
            ),
          ),
        ),
      ],
    );
  }

  _textoInformacao() {
    return Container(
      width: _deviceSize.width,
      height: _deviceSize.height * 0.07,
      color: const Color(0xFF3B7554),
      padding: const EdgeInsets.all(3.0),
      child: Opacity(
        opacity: 0.65,
        child: Center(
          child: Text(
            "Total a receber: R\$ ${_clienteAtualState.totalEmAberto.toStringAsFixed(2)}",
            style: const TextStyle(color: Color(0xFFFDFFFF), fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _onScrollCarregarMaisVendas() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !_clienteAtualState.carregando) {
      ref
          .read(clienteAtualProvider(_idCliente).notifier)
          .getMaisVendasPorClienteLazyLoading(
            startDate: Helpers.dateTimeToDbDate(_dateStart),
            endDate: Helpers.dateTimeToDbDate(_dateEnd),
          );
    }
  }

  void _carregarVendasPorData(String dateStart, String dateEnd) async {
    if (!_clienteAtualState.carregando) {
      _dateStart = dateStart;
      _dateEnd = dateEnd;
      ref
          .read(clienteAtualProvider(_idCliente).notifier)
          .getVendasPorClienteLazyLoading(
            startDate: Helpers.dateTimeToDbDate(dateStart),
            endDate: Helpers.dateTimeToDbDate(dateEnd),
          );
    }
  }

  _limparDados() {
    ref.read(clienteAtualProvider(widget.idCliente).notifier).limparDados();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
