import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/nav.dart';

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
          _floatingActionButton(
              "Cadastro de cliente",
              "assets/images/account_client_icon.png",
              context,
              "/cadastro_cliente"),
          _botaoDialogVenda(
              "Venda", "assets/images/buy_shop_icon.png", context),
          _floatingActionButton(
              "Pesquisa de cliente",
              "assets/images/find_search_icon.png",
              context,
              "/pesquisa_cliente"),
        ],
      ),
    );
  }

  _botaoDialogVenda(String tooltip, String icon, BuildContext context) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      backgroundColor: const Color(0xFF17CA84),
      tooltip: tooltip,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFF910029)),
        borderRadius: BorderRadius.circular(100),
      ),
      onPressed: () => _onTapDialog(context),
      child: Image.asset(
        icon,
        height: MediaQuery.of(context).size.height * 0.06,
      ),
    );
  }

  _floatingActionButton(
      String tooltip, String icon, BuildContext context, String routeName) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      backgroundColor: const Color(0xFF17CA84),
      tooltip: tooltip,
      onPressed: () => pushNamed(context, routeName),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFF910029)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image.asset(
        icon,
        height: MediaQuery.of(context).size.height * 0.06,
      ),
    );
  }

  _onTapDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            margin: const EdgeInsets.only(top: 15),
            color: const Color(0xFF910029),
            child: const Text(
              textAlign: TextAlign.center,
              "Venda",
              style: TextStyle(
                color: Color(0xFFFDFFFF),
                fontSize: 30,
              ),
            ),
          ),
          backgroundColor: const Color(0xFF006940),
          shape: const RoundedRectangleBorder(
              side: BorderSide(
                width: 4,
                color: Color(0xFF910029),
              ),
              borderRadius: BorderRadius.all(Radius.circular(26))),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _botaoVenda(context, "Rua", "/cadastro_venda_rua"),
                _botaoVenda(context, "Fiado", "/cadastro_venda_fiado"),
              ],
            ),
          ),
        );
      },
    );
  }

  _botaoVenda(context, botaoTexto, routeName) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: const Color(0xFF910029),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () => {
          Navigator.pop(context),
          pushReplacementNamed(context, routeName),
        },
        child: Text(
          botaoTexto,
          style: const TextStyle(
            color: Color(0xFFFDFFFF),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
