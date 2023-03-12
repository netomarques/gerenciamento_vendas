import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/abatimento.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/pages/widgets/abatimentos_widget.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field.dart';
import 'package:intl/intl.dart';

class ListaPagamento extends StatefulWidget {
  final Venda _venda;

  const ListaPagamento(this._venda, {super.key});

  @override
  State<ListaPagamento> createState() => _ListaPagamentoState();
}

class _ListaPagamentoState extends State<ListaPagamento> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yy');
  late final StreamController<List<Abatimento>> _abatimentosStreamController;
  late Cliente _cliente;
  late final Future<double> _totalAReceber;
  double _largura = 0.0;
  double _altura = 0.0;

  @override
  void initState() {
    super.initState();
    _abatimentosStreamController = StreamController<List<Abatimento>>();
    _totalAReceber = _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;

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
          width: _largura,
          height: _altura * 0.07,
          color: const Color(0xFF3B7554),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _textTotalAReceber(),
              _botaoAbatimento(),
            ],
          ),
        ),
        _venda(),
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

            return AbatimentosWidget(abatimentosVenda);
          },
        )
      ],
    );
  }

  _head() {
    return Stack(
      children: <Widget>[
        Container(
          width: _largura,
          height: _altura * 0.23,
          color: const Color(0xFF910029),
          child: Column(
            children: <Widget>[
              Container(
                color: const Color(0xFF006940),
                width: _largura,
                height: _altura * 0.075,
              ),
              Container(
                height: _altura * 0.085,
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
          margin: EdgeInsets.only(top: 8, left: _largura * 0.40),
          child: Image.asset(
            "assets/images/client_avatar_icon.png",
            height: _altura * 0.1,
          ),
        ),
      ],
    );
  }

  _textTotalAReceber() {
    return Container(
      height: _altura * 0.07,
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
      height: _altura * 0.07,
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
      height: _altura * 0.07,
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
            height: _altura * 0.3,
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
      margin: EdgeInsets.symmetric(horizontal: _largura * 0.1),
      width: _largura * 0.5,
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

  _venda() {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
      width: _largura,
      height: _altura * 0.155,
      color: widget._venda.isFiado()
          ? const Color(0xFF910029)
          : const Color(0xFF006940),
      child: Row(
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _vendaData(),
                _vendaQuantidadePrecoPorKG(),
              ]),
          _vendaValorTotal(),
        ],
      ),
    );
  }

  _vendaData() {
    return Container(
      width: _largura * 0.26,
      height: _altura * 0.03,
      margin: const EdgeInsets.only(left: 8, top: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFFFF),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          _dateFormat.format(widget._venda.data),
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF969CAF),
          ),
        ),
      ),
    );
  }

  _vendaQuantidadePrecoPorKG() {
    return Container(
      width: _largura * 0.5,
      height: 61,
      margin: const EdgeInsets.only(left: 8, top: 8),
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/images/checkout_price_icon.png",
          ),
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const <Widget>[
                  Text(
                    'Quant: ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFFDFFFF),
                    ),
                  ),
                  Opacity(
                    opacity: 0.6,
                    child: Text(
                      'Preço/kg: ',
                      style: TextStyle(
                        fontSize: 8,
                        color: Color(0xFFFDFFFF),
                      ),
                    ),
                  ),
                ]),
          ),
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '${widget._venda.quantidade.toStringAsFixed(2)} Kg',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFDFFFF),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    '${widget._venda.preco.toStringAsFixed(2)} Kg',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFDFFFF),
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

  _vendaValorTotal() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(right: 6, top: 8),
        alignment: Alignment.topRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(color: Color(0xFFFDFFFF), fontSize: 12),
                ),
                Text(
                  "R\$ ${widget._venda.getTotal().toStringAsFixed(2)}",
                  style:
                      const TextStyle(color: Color(0xFFFDFFFF), fontSize: 24),
                ),
              ],
            ),
            Text(
              _cliente.nome,
              style: const TextStyle(color: Color(0xFFFDFFFF), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Future<double> _carregarDados() async {
    _cliente = widget._venda.cliente;

    List<Abatimento> abatimentoVendas = widget._venda.getAbatimentosVenda();

    _abatimentosStreamController.add(abatimentoVendas);

    return widget._venda.getTotalEmAberto();
  }

  @override
  void dispose() {
    _abatimentosStreamController.close();
    super.dispose();
  }
}
