import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/widgets/app_text_form_field.dart';

class ListaPagamento extends StatefulWidget {
  const ListaPagamento({super.key});

  @override
  State<ListaPagamento> createState() => _ListaPagamentoState();
}

class _ListaPagamentoState extends State<ListaPagamento> {
  Size _size = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

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
          width: _size.width,
          height: _size.height * 0.07,
          color: const Color(0xff3B7554),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _textoInformacao("A receber: R\$ 1200,00"),
              _botaoAbatimento(),
            ],
          ),
        ),
        _venda(),
        _textoInformacao("Histórico de abatimento"),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _abatimento();
            },
            itemCount: 4,
          ),
        )
      ],
    );
  }

  _head() {
    return Stack(
      children: <Widget>[
        Container(
          width: _size.width,
          height: _size.height * 0.23,
          color: const Color(0xFF910029),
          child: Column(
            children: <Widget>[
              Container(
                color: const Color(0xFF006940),
                width: _size.width,
                height: _size.height * 0.075,
              ),
              Container(
                height: _size.height * 0.085,
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Text(
                      "Jose Costa Larga",
                      style: TextStyle(color: Color(0xffFDFFFF), fontSize: 16),
                    ),
                    Text(
                      "92991235963",
                      style: TextStyle(
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
          margin: EdgeInsets.only(top: 8, left: _size.width * 0.40),
          child: Image.asset(
            "assets/images/client_avatar_icon.png",
            height: _size.height * 0.1,
          ),
        ),
      ],
    );
  }

  _textoInformacao(text) {
    return Container(
      //width: _size.width,
      height: _size.height * 0.07,
      color: const Color(0xFF3B7554),
      padding: const EdgeInsets.all(3.0),
      child: Opacity(
        opacity: 0.65,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xffFDFFFF), fontSize: 20),
          ),
        ),
      ),
    );
  }

  _textoInformacaoDialog(text) {
    return Container(
      height: _size.height * 0.07,
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
            height: _size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _textoInformacaoDialog("A receber: R\$ 1200,00"),
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
      margin: EdgeInsets.symmetric(horizontal: _size.width * 0.1),
      width: _size.width * 0.5,
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
      margin: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
      width: _size.width,
      height: _size.height * 0.155,
      color: const Color(0xFF006940),
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

  _abatimento() {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
      width: _size.width,
      height: _size.height * 0.155,
      color: const Color(0xFF006940),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _abatimentoData(),
          _abatimentoValor(),
        ],
      ),
    );
  }

  _abatimentoData() {
    return Container(
      width: _size.width * 0.26,
      height: _size.height * 0.03,
      margin: const EdgeInsets.only(left: 16, top: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFFFF),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Text(
        '24 JAN 2023',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF969CAF),
        ),
      ),
    );
  }

  _abatimentoValor() {
    return Container(
      width: _size.width * 0.6,
      height: _size.height * 0.095,
      margin: const EdgeInsets.only(left: 16, top: 8),
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/images/save_money_icon.png",
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: const Text(
              "R\$ 300,00",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFDFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _vendaData() {
    return Container(
      width: _size.width * 0.26,
      height: _size.height * 0.03,
      margin: const EdgeInsets.only(left: 8, top: 8),
      decoration: BoxDecoration(
        color: const Color(0xffFDFFFF),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Text(
        '24 JAN 2023',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff969CAF),
        ),
      ),
    );
  }

  _vendaQuantidadePrecoPorKG() {
    return Container(
      width: _size.width * 0.5,
      height: 61,
      margin: const EdgeInsets.only(left: 8, top: 8),
      child: Row(children: <Widget>[
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
                    color: Color(0xffffffff),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    'Preço/kg: ',
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ]),
        ),
        Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                Text(
                  '80 Kg',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xfffdffff),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    'R\$ 12,00',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xfffdffff),
                    ),
                  ),
                ),
              ]),
        ),
      ]),
    );
  }

  _vendaValorTotal() {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.only(top: 8),
      alignment: Alignment.topRight,
      child: const Text(
        "R\$ 18000,00",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
