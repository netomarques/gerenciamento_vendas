import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';

class NavButtonsFloating extends ConsumerWidget {
  static NavButtonsFloating builder(
          BuildContext context, GoRouterState state) =>
      NavButtonsFloating();

  NavButtonsFloating({super.key});

  late BuildContext _context;
  late Size _size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    // Size size = MediaQuery.of(context).size;
    _size = context.devicesize;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF17CA84),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(right: 38, left: 38, bottom: 2),
      width: _size.width * 0.8,
      height: _size.height * 0.095,
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _floatingActionButtonRiver(
              "Cadastro de cliente",
              "assets/images/account_client_icon.png",
              RouteLocation.cadastroCliente),
          _botaoDialogVenda("Venda", "assets/images/buy_shop_icon.png"),
          _floatingActionButtonRiver(
              "Pesquisa de cliente",
              "assets/images/find_search_icon.png",
              RouteLocation.pesquisaCliente),
        ],
      ),
    );
  }

  _botaoDialogVenda(String tooltip, String icon) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      backgroundColor: const Color(0xFF17CA84),
      tooltip: tooltip,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFF910029)),
        borderRadius: BorderRadius.circular(100),
      ),
      onPressed: () => _onTapDialog(),
      child: Image.asset(
        icon,
        height: _size.height * 0.06,
        // height: MediaQuery.of(context).size.height * 0.06,
      ),
    );
  }

  // _floatingActionButton(
  //     String tooltip, String icon, BuildContext context, String routeName) {
  //   return FloatingActionButton(
  //     heroTag: UniqueKey(),
  //     backgroundColor: const Color(0xFF17CA84),
  //     tooltip: tooltip,
  //     onPressed: () => pushNamed(context, routeName),
  //     shape: RoundedRectangleBorder(
  //       side: const BorderSide(width: 1, color: Color(0xFF910029)),
  //       borderRadius: BorderRadius.circular(100),
  //     ),
  //     child: Image.asset(
  //       icon,
  //       height: MediaQuery.of(context).size.height * 0.06,
  //     ),
  //   );
  // }

  // _floatingActionButtonReplacement(
  //     String tooltip, String icon, BuildContext context, String routeName) {
  //   return FloatingActionButton(
  //     heroTag: UniqueKey(),
  //     backgroundColor: const Color(0xFF17CA84),
  //     tooltip: tooltip,
  //     onPressed: () => pushReplacementNamed(context, routeName),
  //     shape: RoundedRectangleBorder(
  //       side: const BorderSide(width: 1, color: Color(0xFF910029)),
  //       borderRadius: BorderRadius.circular(100),
  //     ),
  //     child: Image.asset(
  //       icon,
  //       height: MediaQuery.of(context).size.height * 0.06,
  //     ),
  //   );
  // }

  _floatingActionButtonReplacementRiver(
      String tooltip, String icon, String routeLocation) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      backgroundColor: const Color(0xFF17CA84),
      tooltip: tooltip,
      onPressed: () => _context.go(routeLocation),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFF910029)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image.asset(
        icon,
        height: _size.height * 0.06,
      ),
    );
  }

  _floatingActionButtonRiver(
      String tooltip, String icon, String routeLocation) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      backgroundColor: const Color(0xFF17CA84),
      tooltip: tooltip,
      onPressed: () => _context.push(routeLocation),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFF910029)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image.asset(
        icon,
        height: _size.height * 0.06,
      ),
    );
  }

  _onTapDialog() {
    showDialog(
      context: _context,
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
            height: _size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _botaoVenda("Rua", RouteLocation.cadastroVendaRua),
                _botaoVenda("Fiado", RouteLocation.cadastroVendaFiado),
              ],
            ),
          ),
        );
      },
    );
  }

  _botaoVenda(botaoTexto, routeLocation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _size.width * 0.1),
      width: _size.width * 0.5,
      decoration: BoxDecoration(
        color: const Color(0xFF910029),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () => {
          Navigator.pop(_context),
          _context.push(routeLocation),
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
