import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/nav.dart';
import 'package:vendas_gerenciamento/widgets/nav_buttons_floating.dart';

class PesquisaCliente extends StatefulWidget {
  const PesquisaCliente({super.key});

  @override
  State<PesquisaCliente> createState() => _PesquisaClienteState();
}

class _PesquisaClienteState extends State<PesquisaCliente> {
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
    return Container(
      color: const Color(0xFF006940),
      child: Column(
        children: <Widget>[
          _tituloForm(),
          _containerText(),
          Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: const Divider(color: Color(0xFF910029), thickness: 1)),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: _containerCliente(),
                  onTap: () => pushNamed(context, "/painel_cliente"),
                );
              },
              itemCount: 7,
            ),
          ),
          const NavButtonsFloating(),
        ],
      ),
    );
  }

  _tituloForm() {
    return Container(
      width: _size.width,
      height: _size.height * 0.1,
      color: const Color(0xff910029),
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: const Text(
        'Clientes',
        style: TextStyle(
          color: Color(0xffFDFFFF),
          fontSize: 30,
        ),
      ),
    );
  }

  _containerText() {
    return Container(
      height: _size.height * 0.08,
      margin: const EdgeInsets.only(left: 16, top: 20, right: 32, bottom: 16),
      child: _textForm("Nome", "Nome do cliente"),
    );
  }

  _textForm(labelText, hintText) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFFFF),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF910029),
        ),
        decoration: InputDecoration(
          icon: Image.asset(
            "assets/images/find_search_icon.png",
            height: _size.height * 0.05,
          ),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 14, color: Color(0xFF006940)),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xff910029),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  _containerCliente() {
    return Container(
      color: const Color(0xFFB6C5DE),
      height: MediaQuery.of(context).size.height * 0.1,
      margin: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const <Widget>[
          Text(
            "José Costa Larga",
            style: TextStyle(
              color: Color(0xFF910029),
              fontSize: 16,
            ),
          ),
          Text(
            "92991235963",
            style: TextStyle(
              color: Color(0xFF910029),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
