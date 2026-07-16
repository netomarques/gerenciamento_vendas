import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/pages/widgets/viagens_widget.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:vendas_gerenciamento/widgets/date_button.dart';

class PainelBarco extends ConsumerStatefulWidget {
  final int idBarco;

  static PainelBarco builder(BuildContext context, GoRouterState state) =>
      PainelBarco(state.extra as int);

  const PainelBarco(this.idBarco, {super.key});

  @override
  ConsumerState<PainelBarco> createState() => _PainelBarcoState();
}

class _PainelBarcoState extends ConsumerState<PainelBarco> {
  late DateTime _dateStart;
  late DateTime _dateEnd;
  late Size _deviceSize;
  late BarcoState _barcoState;
  late final Cliente _cliente;
  late final ScrollController scrollController;
  late NumberFormat _formatterMoeda;
  late final NumberFormat _formatterPeso;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(barcoProvider(widget.idBarco).notifier).getBarcoRelatorio();
    });
    _carregarDados();
  }

  _carregarDados() {
    _formatterMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    _formatterPeso = NumberFormat('#,##0.00 kg', 'pt_BR');
    scrollController = ScrollController();
    scrollController.addListener(_onScrollCarregarMaisVendas);
    _dateStart = DateTime.now();
    _dateEnd = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _barcoState = ref.watch(barcoProvider(widget.idBarco));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB710A),
        title: _barcoState.carregando
            ? const Center(child: CircularProgressIndicator())
            : Text(
                _barcoState.barco!.nome,
                style: const TextStyle(color: Color(0xFFFDFFFF), fontSize: 16),
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
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
              width: _deviceSize.width * 0.35,
              child: DateButton(_dateStart, _dateEnd, _carregarVendasPorData)),
        ),
        ViagensWidget(
            viagens: _barcoState.viagens,
            route: RouteLocation.painelViagem,
            scrollController: scrollController),
        _barcoState.carregando
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
          height: _deviceSize.height * 0.40,
          color: const Color(0xFFEB710A),
          child: Column(
            children: <Widget>[
              Container(
                color: const Color(0xFF006940),
                width: _deviceSize.width,
                height: _deviceSize.height * 0.075,
              ),
              Container(
                // height: _deviceSize.height * 0.2,
                margin: const EdgeInsets.only(top: 30),
                child: _barcoState.carregando
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: <Widget>[
                          _containerDados(
                              'Peso total: ',
                              _formatterPeso
                                  .format(_barcoState.pesoTotal?.toDouble())),
                          _containerDados(
                              'Peso total vendido: ',
                              _formatterPeso.format(
                                  _barcoState.pesoTotalVendido?.toDouble())),
                          _containerDados('Número de vendas: ',
                              _barcoState.numeroDeVendas.toString()),
                          _containerDados(
                              'Total das vendas: ',
                              _formatterMoeda.format(
                                  _barcoState.totalDasVendas?.toDouble())),
                          _containerDados('Número de venda rua: ',
                              _barcoState.numeroDeVendaRua.toString()),
                          _containerDados(
                              'Total venda rua: ',
                              _formatterMoeda.format(
                                  _barcoState.totalVendaRua?.toDouble())),
                          _containerDados('Número de venda fiado: ',
                              _barcoState.numeroDeVendaFiado.toString()),
                          _containerDados(
                              'Total venda fiado: ',
                              _formatterMoeda.format(
                                  _barcoState.totalVendaFiado?.toDouble())),
                          _containerDados(
                              'Total recebido venda fiado: ',
                              _formatterMoeda.format(_barcoState
                                  .totalRecebidoVendaFiado
                                  ?.toDouble())),
                          _containerDados(
                              'Total a receber venda fiado: ',
                              _formatterMoeda.format(_barcoState
                                  .totalAReceberVendaFiado
                                  ?.toDouble())),
                        ],
                      ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8, left: _deviceSize.width * 0.40),
          child: Image.asset(
            'assets/images/boat_icon.png',
            height: _deviceSize.height * 0.1,
          ),
        ),
      ],
    );
  }

  _containerDados(label, valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerRight,
          width: _deviceSize.width * 0.52,
          child: _text(label),
        ),
        Container(
          width: _deviceSize.width * 0.40,
          alignment: Alignment.centerLeft,
          child: _text(valor),
        ),
      ],
    );
  }

  _text(text, {double fontSize = 16.0}) {
    return Text(text,
        style: TextStyle(color: const Color(0xFFFDFFFF), fontSize: fontSize));
  }

  void _onScrollCarregarMaisVendas() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !_barcoState.carregando) {
      ref
          .read(clienteAtualProvider(_cliente).notifier)
          .getMaisVendasPorClienteLazyLoading(
              startDate: _dateStart, endDate: _dateEnd);
    }
  }

  void _carregarVendasPorData(DateTime dateStart, DateTime dateEnd) async {
    if (!_barcoState.carregando) {
      _dateStart = dateStart;
      _dateEnd = dateEnd;
      ref
          .read(clienteAtualProvider(_cliente).notifier)
          .getVendasPorClienteLazyLoading(
              startDate: _dateStart, endDate: _dateEnd);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
