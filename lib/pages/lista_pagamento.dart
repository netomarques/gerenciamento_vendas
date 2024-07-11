import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/cadastro_abatimento.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListaPagamento extends ConsumerStatefulWidget {
  final int idVenda;

  static ListaPagamento builder(BuildContext context, GoRouterState state) =>
      ListaPagamento(idVenda: state.extra! as int);

  const ListaPagamento({super.key, required this.idVenda});

  @override
  ConsumerState<ListaPagamento> createState() => _ListaPagamentoState();
}

class _ListaPagamentoState extends ConsumerState<ListaPagamento> {
  late final int _idVenda;
  late VendaState _vendaState;
  late Size _deviceSize;

  @override
  void initState() {
    _idVenda = widget.idVenda;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _vendaState = ref.watch(vendaProvider(_idVenda));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB710A),
        title: const Text(
          'Venda - Abatimentos',
          style: TextStyle(
            color: Color(0xffFDFFFF),
          ),
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
        _vendaState.carregando
            ? const CircularProgressIndicator()
            : VendaWidget(venda: _vendaState.venda!),
        _textoInformacao(),
        Expanded(
          child: _vendaState.carregando
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _vendaState.abatimentosDaVenda.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    Abatimento abatimento =
                        _vendaState.abatimentosDaVenda[index];
                    return AbatimentoWidget(abatimento: abatimento);
                  }),
                ),
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
                child: _vendaState.carregando
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            _vendaState.venda!.cliente.nome,
                            style: const TextStyle(
                                color: Color(0xffFDFFFF), fontSize: 16),
                          ),
                          Text(
                            _vendaState.venda!.cliente.telefone,
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
          child: _vendaState.carregando
              ? const CircularProgressIndicator()
              : Text(
                  "A receber: R\$ ${_vendaState.venda!.totalAberto!.toStringAsFixed(2)}",
                  style:
                      const TextStyle(color: Color(0xFFFDFFFF), fontSize: 20),
                ),
        ),
      ),
    );
  }

  _textoInformacao() {
    return Container(
      height: _deviceSize.height * 0.07,
      color: const Color(0xFF3B7554),
      padding: const EdgeInsets.all(3.0),
      child: const Opacity(
        opacity: 0.65,
        child: Center(
          child: Text(
            'Histórico de abatimento',
            style: TextStyle(color: Color(0xFFFDFFFF), fontSize: 20),
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
        if (_vendaState.venda!.totalAberto! > 0.0) {
          return CadastroAbatimento(_vendaState.venda!);
        } else {
          return AlertDialog(
            backgroundColor: const Color(0xFF006940),
            content: const Text(
              'Não há valores em aberto',
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Color(0xFFFDFFFF),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
