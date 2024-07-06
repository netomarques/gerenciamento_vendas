import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/abatimento.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/pages/widgets/abatimento_widget.dart';
import 'package:vendas_gerenciamento/pages/widgets/venda_widget.dart';
import 'package:vendas_gerenciamento/providers/services/services.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListaPagamento extends ConsumerStatefulWidget {
  final Venda venda;

  static ListaPagamento builder(BuildContext context, GoRouterState state) =>
      ListaPagamento(venda: state.extra! as Venda);

  const ListaPagamento({super.key, required this.venda});

  @override
  ConsumerState<ListaPagamento> createState() => _ListaPagamentoState();
}

class _ListaPagamentoState extends ConsumerState<ListaPagamento> {
  late final StreamController<List<Abatimento>> _abatimentosStreamController;
  late final Cliente _cliente;
  late final Venda _venda;
  late final Future<double> _totalAReceber;
  late VendaService _vendaService;
  late Size _deviceSize;

  @override
  void initState() {
    super.initState();
    _abatimentosStreamController = StreamController<List<Abatimento>>();
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _vendaService = ref.watch(vendaServiceProvider);
    _carregarAbatimentos();

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        _head(),
        Container(
          width: _deviceSize.width,
          height: _deviceSize.height * 0.07,
          color: const Color(0xFF3B7554),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _textTotalAReceber(),
              _botaoAbatimento(),
            ],
          ),
        ),
        VendaWidget(venda: _venda),
        _textoInformacao("Histórico de abatimento"),
        StreamBuilder<List<Abatimento>>(
          stream: _abatimentosStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Expanded(
                child: Center(child: Text('Erro: ${snapshot.error}')),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final List<Abatimento> abatimentosVenda = snapshot.data!;

            return Expanded(
              child: ListView.builder(
                itemCount: abatimentosVenda.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  Abatimento abatimento = abatimentosVenda[index];
                  return AbatimentoWidget(abatimento: abatimento);
                }),
              ),
            );
          },
        )
      ],
    );
  }

  _head() {
    return Stack(
      children: <Widget>[
        Container(
          width: _deviceSize.width,
          height: _deviceSize.height * 0.23,
          color: const Color(0xFF910029),
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
                      _cliente.nome,
                      style: const TextStyle(
                          color: Color(0xffFDFFFF), fontSize: 16),
                    ),
                    Text(
                      _cliente.telefone,
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
        Container(
          margin: EdgeInsets.only(top: 8, left: _deviceSize.width * 0.40),
          child: Image.asset(
            "assets/images/client_avatar_icon.png",
            height: _deviceSize.height * 0.1,
          ),
        ),
      ],
    );
  }

  _textTotalAReceber() {
    return Container(
      height: _deviceSize.height * 0.07,
      color: const Color(0xFF3B7554),
      padding: const EdgeInsets.all(3.0),
      child: Opacity(
        opacity: 0.65,
        child: Center(
          child: FutureBuilder<double>(
            future: _totalAReceber,
            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  "A receber: R\$ ${snapshot.data!.toStringAsFixed(2)}",
                  style:
                      const TextStyle(color: Color(0xFFFDFFFF), fontSize: 20),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  _textoInformacao(text) {
    return Container(
      height: _deviceSize.height * 0.07,
      color: const Color(0xFF3B7554),
      padding: const EdgeInsets.all(3.0),
      child: Opacity(
        opacity: 0.65,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFFFDFFFF), fontSize: 20),
          ),
        ),
      ),
    );
  }

  _textoInformacaoDialog(text) {
    return Container(
      height: _deviceSize.height * 0.07,
      color: const Color(0xFF3B7554),
      padding: const EdgeInsets.all(3.0),
      child: Opacity(
        opacity: 0.65,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF7AA28B), fontSize: 20),
          ),
        ),
      ),
    );
  }

  _botaoAbatimento() {
    return GestureDetector(
      onTap: () => _onTapDialog(),
      child: Image.asset("assets/images/check_money_icon.png"),
    );
  }

  _onTapDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF006940),
          shape: const RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: Color(0xFF910029),
              ),
              borderRadius: BorderRadius.all(Radius.circular(26))),
          content: SizedBox(
            height: _deviceSize.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FutureBuilder<double>(
                  future: _totalAReceber,
                  builder:
                      (BuildContext context, AsyncSnapshot<double> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return _textoInformacaoDialog(
                          "A receber: R\$ ${snapshot.data!.toStringAsFixed(2)}");
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const AppTextFormField("Valor do abatimento", "valor"),
                const AppTextFormField(
                    "Data do abatimento", "Data de abatimento"),
              ],
            ),
          ),
          actions: [
            _botaoCadastrarAbatimento(),
          ],
        );
      },
    );
  }

  _botaoCadastrarAbatimento() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _deviceSize.width * 0.1),
      width: _deviceSize.width * 0.5,
      decoration: BoxDecoration(
        color: const Color(0xFF910029),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () => {},
        child: const Text(
          "Cadastrar",
          style: TextStyle(
            color: Color(0xFFFDFFFF),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Future<void> _carregarDados() async {
    _venda = widget.venda;
    _cliente = _venda.cliente;
    _totalAReceber = Future.value(_venda.totalAberto);
  }

  Future<void> _carregarAbatimentos() async {
    List<Abatimento> abatimentoVendas =
        await _vendaService.getAbatimentosPorVenda(_venda.id);
    _abatimentosStreamController.add(abatimentoVendas);
  }

  @override
  void dispose() {
    _abatimentosStreamController.close();
    super.dispose();
  }
}
