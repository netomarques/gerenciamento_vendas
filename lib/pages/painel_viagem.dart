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

class PainelViagem extends ConsumerStatefulWidget {
  final Viagem viagem;

  static PainelViagem builder(BuildContext context, GoRouterState state) =>
      PainelViagem(state.extra as Viagem);

  const PainelViagem(this.viagem, {super.key});

  @override
  ConsumerState<PainelViagem> createState() => _PainelViagemState();
}

class _PainelViagemState extends ConsumerState<PainelViagem> {
  late DateTime _dateStart;
  late DateTime _dateEnd;
  late Size _deviceSize;
  late ViagemRelatorioState _viagemState;
  late final Viagem _viagem;
  late final ScrollController scrollController;
  late NumberFormat _formatterMoeda;
  late final NumberFormat _formatterPeso;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() {
    _viagem = widget.viagem;
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
    _viagemState = ref.watch(viagemProvider(_viagem));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB710A),
        title: Text(
          'Painel Viagem - Chegada ${Helpers.formatarDateTimeToString(_viagem.dateChegada)}',
          style: const TextStyle(color: Color(0xFFFDFFFF), fontSize: 16),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  Column _body() {
    return Column(
      children: <Widget>[
        _head(),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
              width: _deviceSize.width * 0.35,
              child: DateButton(_dateStart, _dateEnd, _carregarVendasPorData)),
        ),
        VendasWidget(
          vendas: _viagemState.vendas,
          route: RouteLocation.listarPagamentos,
          scrollController: scrollController,
        ),
        _viagemState.carregando
            ? const CircularProgressIndicator()
            : Container(),
      ],
    );
  }

  Stack _head() {
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
                margin: const EdgeInsets.only(top: 30),
                child: _viagemState.carregando
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: <Widget>[
                          _containerDados(
                              'Peso total: ',
                              _formatterPeso
                                  .format(_viagemState.pesoTotal?.toDouble())),
                          _containerDados(
                              'Peso total vendido: ',
                              _formatterPeso.format(
                                  _viagemState.pesoTotalVendido?.toDouble())),
                          _containerDados('Número de vendas: ',
                              _viagemState.numeroDeVendas.toString()),
                          _containerDados(
                              'Total das vendas: ',
                              _formatterMoeda.format(
                                  _viagemState.totalDasVendas?.toDouble())),
                          _containerDados('Número de venda rua: ',
                              _viagemState.numeroDeVendaRua.toString()),
                          _containerDados(
                              'Total venda rua: ',
                              _formatterMoeda.format(
                                  _viagemState.totalVendaRua?.toDouble())),
                          _containerDados('Número de venda fiado: ',
                              _viagemState.numeroDeVendaFiado.toString()),
                          _containerDados(
                              'Total venda fiado: ',
                              _formatterMoeda.format(
                                  _viagemState.totalVendaFiado?.toDouble())),
                          _containerDados(
                              'Total recebido venda fiado: ',
                              _formatterMoeda.format(_viagemState
                                  .totalRecebidoVendaFiado
                                  ?.toDouble())),
                          _containerDados(
                              'Total a receber venda fiado: ',
                              _formatterMoeda.format(_viagemState
                                  .totalAReceberVendaFiado
                                  ?.toDouble())),
                        ],
                      ),
              ),
            ],
          ),
        ),
        GestureDetector(
          // onTap: () =>
          //     context.push(RouteLocation.alterarCliente, extra: _cliente),
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(top: 8, left: _deviceSize.width * 0.40),
            child: Image.asset(
              'assets/images/boat_icon.png',
              height: _deviceSize.height * 0.1,
            ),
          ),
        ),
      ],
    );
  }

  Row _containerDados(String label, String valor) {
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

  Text _text(String text, {double fontSize = 16.0}) {
    return Text(text,
        style: TextStyle(color: const Color(0xFFFDFFFF), fontSize: fontSize));
  }

  void _onScrollCarregarMaisVendas() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !_viagemState.carregando) {
      // ref
      //     .read(clienteAtualProvider(_cliente).notifier)
      //     .getMaisVendasPorClienteLazyLoading(
      //         startDate: _dateStart, endDate: _dateEnd);
    }
  }

  void _carregarVendasPorData(DateTime dateStart, DateTime dateEnd) async {
    if (!_viagemState.carregando) {
      _dateStart = dateStart;
      _dateEnd = dateEnd;
      // ref
      //     .read(clienteAtualProvider(_cliente).notifier)
      //     .getVendasPorClienteLazyLoading(
      //         startDate: _dateStart, endDate: _dateEnd);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
