import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/widgets/venda_widget.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';
import 'package:vendas_gerenciamento/widgets/date_button.dart';
import 'package:vendas_gerenciamento/widgets/nav_buttons_floating.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomePainel extends ConsumerStatefulWidget {
  static HomePainel builder(BuildContext context, GoRouterState state) =>
      const HomePainel();
  const HomePainel({super.key});

  @override
  ConsumerState<HomePainel> createState() => _HomePainelState();
}

class _HomePainelState extends ConsumerState<HomePainel> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  late final TextEditingController startDateController;
  late final TextEditingController endDateController;
  late final StreamController<List<Venda>> _vendasStreamController;
  late final StreamController<Map<String, dynamic>> _resumoStreamController;
  late Size _deviceSize;
  late VendaState _vendasState;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _vendasState = ref.watch(vendaProvider);
    _vendasStreamController.add(_vendasState.list);
    resumoVendas();

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: _body(),
    );
  }

  Column _body() {
    return Column(
      children: [
        _painel(),
        _textoInformacao(),
        StreamBuilder<List<Venda>>(
          stream: _vendasStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Expanded(
                child: Center(child: Text('Erro: ${snapshot.error}')),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final List<Venda> vendas = snapshot.data!;

            return Expanded(
              child: ListView.builder(
                itemCount: vendas.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Venda venda = vendas[index];
                  return GestureDetector(
                    onTap: () => context.push(RouteLocation.listarPagamentos,
                        extra: venda),
                    child: VendaWidget(venda: venda),
                  );
                },
              ),
            );
          },
        ),
        const NavButtonsFloating(),
      ],
    );
  }

  _painel() {
    return Container(
      width: _deviceSize.width,
      height: _deviceSize.height * 0.25,
      color: const Color(0xff910029),
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
          Container(
            alignment: Alignment.topLeft,
            child: StreamBuilder<Map<String, dynamic>>(
              stream: _resumoStreamController.stream,
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return const Text(
                    'Erro:',
                    style: TextStyle(color: Colors.white, fontSize: 2),
                  );
                }

                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return Text(
                  'R\$ ${snapshot.data!["Vendas"]["Total"].toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 32),
                );
              }),
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
      child: DateButton(startDateController.text, endDateController.text,
          pesquisarVendasPorData),
    );
  }

  _painelDados() {
    return SizedBox(
      width: _deviceSize.width,
      child: Row(
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
                  child: StreamBuilder<Map<String, dynamic>>(
                    stream: _resumoStreamController.stream,
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text(
                          'Erro:',
                          style: TextStyle(color: Colors.white, fontSize: 2),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      return Text(
                        snapshot.data!["Vendas"]["Quantidade"]
                            .toString()
                            .padLeft(2, '0'),
                        style: const TextStyle(
                            color: Color(0xfffdffff), fontSize: 16),
                      );
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 8),
                  child: const Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Total de vendas',
                      style: TextStyle(color: Color(0xfffdffff), fontSize: 12),
                    ),
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
      child: StreamBuilder<Map<String, dynamic>>(
        stream: _resumoStreamController.stream,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              'Erro:',
              style: TextStyle(color: Colors.white, fontSize: 2),
            );
          }

          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return Row(
            children: <Widget>[
              SizedBox(
                width: _deviceSize.width * 0.6 * 0.5,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'R\$ ${snapshot.data!["Rua"]["Total"].toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Color(0xfffdffff), fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Opacity(
                        opacity: 0.5,
                        child: Text(
                          '${snapshot.data!["Rua"]["Quantidade"].toString().padLeft(2, '0')} Rua',
                          style: const TextStyle(
                              color: Color(0xfffdffff), fontSize: 12),
                        ),
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
                      child: Text(
                        'R\$ ${snapshot.data!["Fiado"]["Total"].toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Color(0xfffdffff), fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Opacity(
                        opacity: 0.5,
                        child: Text(
                          '${snapshot.data!["Fiado"]["Quantidade"].toString().padLeft(2, '0')} Fiados',
                          style: const TextStyle(
                              color: Color(0xfffdffff), fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
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
    ref.read(vendaProvider.notifier).getVendasPorData(
        Helpers.dateTimeToDbDate(startDate), Helpers.dateTimeToDbDate(endDate));
    startDateController.text = startDate;
    endDateController.text = endDate;

    resumoVendas();
    _vendasStreamController.add(_vendasState.list);
  }

  void resumoVendas() {
    int quantVendaRua, quantVendaFiado;
    double totalVendaRua, totalVendaFiado;
    // NumberFormat numberFormat = NumberFormat('##');

    quantVendaRua = quantVendaFiado = 0;
    totalVendaRua = totalVendaFiado = 0.0;

    for (Venda venda in _vendasState.list) {
      switch (venda.fiado) {
        case true:
          quantVendaFiado += 1;
          totalVendaFiado += venda.total!;
          break;
        case false:
          quantVendaRua += 1;
          totalVendaRua += venda.total!;
          break;
      }
    }

    Map<String, dynamic> resumo = <String, dynamic>{
      "Fiado": {"Total": totalVendaFiado, "Quantidade": quantVendaFiado},
      "Rua": {"Total": totalVendaRua, "Quantidade": quantVendaRua},
      "Vendas": {
        "Total": totalVendaRua + totalVendaFiado,
        "Quantidade": quantVendaRua + quantVendaFiado,
      },
    };

    _resumoStreamController.add(resumo);
    // return resumo;
  }

  void _carregarDados() async {
    _vendasStreamController = StreamController<List<Venda>>();
    _resumoStreamController =
        StreamController<Map<String, dynamic>>.broadcast();
    startDateController =
        TextEditingController(text: _dateFormat.format(DateTime.now()));
    endDateController =
        TextEditingController(text: _dateFormat.format(DateTime.now()));
  }

  @override
  void dispose() {
    _vendasStreamController.close();
    _resumoStreamController.close();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }
}
