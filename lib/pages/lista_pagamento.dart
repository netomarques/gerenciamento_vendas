import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/cadastro_abatimento.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';

class ListaPagamento extends ConsumerStatefulWidget {
  final Venda venda;

  static ListaPagamento builder(BuildContext context, GoRouterState state) =>
      ListaPagamento(venda: state.extra as Venda);

  const ListaPagamento({super.key, required this.venda});

  @override
  ConsumerState<ListaPagamento> createState() => _ListaPagamentoState();
}

class _ListaPagamentoState extends ConsumerState<ListaPagamento> {
  late final NumberFormat _formatterMoeda;
  late final Venda _venda;
  late VendaState _vendaState;
  late Size _deviceSize;

  @override
  void initState() {
    _carregarDados();
    super.initState();
  }

  _carregarDados() {
    _venda = widget.venda;
    _formatterMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _vendaState = ref.watch(vendaProvider(_venda));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB710A),
        title: const Text(
          'Venda - Abatimentos',
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
              ? const Center(child: CircularProgressIndicator())
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
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _text(_venda.cliente.nome),
                    _text(
                      _formatarTelefone(_venda.cliente.telefone),
                    ),
                    _text(_formatarCpfCnpj(_venda.cliente.cpf)),
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

  _textTotalAReceber() {
    return Container(
      height: _deviceSize.height * 0.07,
      color: const Color(0xFF3B7554),
      padding: const EdgeInsets.all(3.0),
      child: Opacity(
        opacity: 0.65,
        child: Center(
          child: _vendaState.carregando
              ? const Center(child: CircularProgressIndicator())
              : Text(
                  "A receber: ${_formatterMoeda.format(_vendaState.venda!.totalAberto!.toDouble())}",
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
        if (_vendaState.venda!.totalAberto! > Decimal.zero) {
          return CadastroAbatimento(_vendaState.venda!);
        } else {
          return const AlertDialogWidget('Não há valores em aberto');
        }
      },
    );
  }

  _limparDados() {
    ref.read(vendaProvider(_venda).notifier).limparDados();
  }
}
