import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/pages/cadastro_cliente.dart';

class NavButtonsFloating extends StatelessWidget {
  const NavButtonsFloating({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF17CA84),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(right: 38, left: 38, bottom: 2),
      width: size.width * 0.8,
      height: size.height * 0.095,
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _floatingActionButton("Cadastro de cliente", Icons.people),
          _floatingActionButton("Venda", Icons.add_shopping_cart),
          _floatingActionButton("Pesquisa de cliente", Icons.search),
        ],
      ),
    );
  }

  _floatingActionButton(String tooltip, IconData iconData) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff910029),
      tooltip: tooltip,
      onPressed: () => {},
      child: Icon(iconData),
    );
  }
}
