import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:vendas_gerenciamento/widgets/date_button.dart';

class PainelCliente extends ConsumerStatefulWidget {
  final Cliente cliente;

  static PainelCliente builder(BuildContext context, GoRouterState state) =>
      PainelCliente(state.extra as Cliente);

  const PainelCliente(this.cliente, {super.key});

  @override
  ConsumerState<PainelCliente> createState() => _PainelClienteState();
}

class _PainelClienteState extends ConsumerState<PainelCliente> {
  late DateTime _dateStart;
  late DateTime _dateEnd;
  late Size _deviceSize;
  late ClienteAtualState _clienteAtualState;
  late final Cliente _cliente;
  late final ScrollController scrollController;
  late NumberFormat _formatterMoeda;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  _carregarDados() {
    _cliente = widget.cliente;
    _formatterMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    scrollController = ScrollController();
    scrollController.addListener(_onScrollCarregarMaisVendas);
    _dateStart = DateTime.now();
    _dateEnd = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _clienteAtualState = ref.watch(clienteAtualProvider(_cliente));

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
        _textoTotalInformacao(),
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
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _text(_clienteAtualState.cliente!.nome),
                    _text(
                      _formatarTelefone(_clienteAtualState.cliente!.telefone),
                    ),
                    _text(_formatarCpfCnpj(_clienteAtualState.cliente!.cpf)),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () =>
              context.push(RouteLocation.alterarCliente, extra: _cliente),
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

  _text(text, {double fontSize = 16.0}) {
    return Text(text,
        style: TextStyle(color: const Color(0xFFFDFFFF), fontSize: fontSize));
  }

  String _formatarTelefone(String telefone) {
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

  String _formatarCpfCnpj(String cpf) {
    final newText = StringBuffer();

    if (cpf.length == 11) {
      newText.write(
          '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}');
    } else {
      newText.write(
          '${cpf.substring(0, 2)}.${cpf.substring(2, 5)}.${cpf.substring(5, 8)}/${cpf.substring(8, 12)}-${cpf.substring(12)}');
    }

    return newText.toString();
  }

  _textoTotalInformacao() {
    return Container(
      width: _deviceSize.width,
      height: _deviceSize.height * 0.07,
      color: const Color(0xFF3B7554),
      padding: const EdgeInsets.all(3.0),
      child: Opacity(
        opacity: 0.65,
        child: Center(
          child: _text(
              'Total a receber: ${_formatterMoeda.format(_clienteAtualState.totalEmAberto.toDouble())}',
              fontSize: 20.0),
        ),
      ),
    );
  }

  void _onScrollCarregarMaisVendas() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !_clienteAtualState.carregando) {
      ref
          .read(clienteAtualProvider(_cliente).notifier)
          .getMaisVendasPorClienteLazyLoading(
              startDate: _dateStart, endDate: _dateEnd);
    }
  }

  void _carregarVendasPorData(DateTime dateStart, DateTime dateEnd) async {
    if (!_clienteAtualState.carregando) {
      _dateStart = dateStart;
      _dateEnd = dateEnd;
      ref
          .read(clienteAtualProvider(_cliente).notifier)
          .getVendasPorClienteLazyLoading(
              startDate: _dateStart, endDate: _dateEnd);
    }
  }

  _limparDados() {
    ref.read(clienteAtualProvider(widget.cliente).notifier).limparDados();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
