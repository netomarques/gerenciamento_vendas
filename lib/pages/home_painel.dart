import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/widgets/nav_buttons_floating.dart';

class HomePainel extends StatefulWidget {
  const HomePainel({super.key});

  @override
  State<HomePainel> createState() => _HomePainelState();
}

class _HomePainelState extends State<HomePainel> {
  Size size = const Size(0, 0);
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

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
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _containerVenda();
            },
            itemCount: 20,
          ),
        ),
        const NavButtonsFloating(),
      ],
    );
  }

  _painel() {
    return Container(
      width: size.width,
      height: size.height * 0.25,
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
      width: size.width,
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
      width: size.width * 0.5,
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
            child: const Text(
              'R\$ 30000,00',
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
          ),
        ],
      ),
    );
  }

  _painelFiltroData() {
    return Container(
      width: size.width * 0.35,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: const Color(0xff486153),
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Text(
        '24 JAN 2023',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  _painelDados() {
    return SizedBox(
      width: size.width,
      child: Row(
        children: <Widget>[
          _painelDadosIcon(),
          _painelDadosValorQuantidade(),
        ],
      ),
    );
  }

  _painelDadosIcon() {
    return SizedBox(
      width: size.width * 0.4,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: size.width * 0.4 * 0.3,
            child: const Icon(
              Icons.auto_graph,
              color: Color(0xffEB710A),
              size: 36.0,
            ),
          ),
          SizedBox(
            width: size.width * 0.4 * 0.7,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text(
                    '04',
                    style: TextStyle(color: Color(0xfffdffff), fontSize: 16),
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
      width: size.width * 0.6,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: size.width * 0.6 * 0.5,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'R\$ 21690,00',
                    style: TextStyle(color: Color(0xfffdffff), fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Opacity(
                    opacity: 0.5,
                    child: Text(
                      '02 Rua',
                      style: TextStyle(color: Color(0xfffdffff), fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: size.width * 0.6 * 0.5,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'R\$ 36000,00',
                    style: TextStyle(color: Color(0xfffdffff), fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Opacity(
                    opacity: 0.5,
                    child: Text(
                      '02 Fiados',
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

  _textoInformacao() {
    return Container(
      width: size.width,
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

  _containerVenda() {
    return GestureDetector(
      onTap: () => {print("Foi")},
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
        width: size.width,
        height: size.height * 0.155,
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
      ),
    );
  }

  _vendaData() {
    return Container(
      width: size.width * 0.26,
      height: size.height * 0.03,
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
      width: size.width * 0.5,
      height: 61,
      margin: const EdgeInsets.only(left: 8, top: 8),
      child: Row(children: <Widget>[
        const Icon(
          Icons.monetization_on,
          color: Color(0xffEB710A),
          size: 60,
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
