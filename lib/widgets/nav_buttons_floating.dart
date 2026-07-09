import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';

class NavButtonsFloating extends ConsumerWidget {
  static NavButtonsFloating builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const NavButtonsFloating();

  const NavButtonsFloating({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF17CA84),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _FloatingActionButtonRiver(
            tooltip: "Cadastro de cliente",
            icon: "assets/images/account_client_icon.png",
            routeLocation: RouteLocation.cadastroCliente,
          ),
          _VendaButtonDialog(
            tooltip: "Venda",
            icon: "assets/images/buy_shop_icon.png",
            // mainContext: context,
          ),
          _FloatingActionButtonRiver(
            tooltip: "Pesquisa de cliente",
            icon: "assets/images/find_search_icon.png",
            routeLocation: RouteLocation.pesquisaCliente,
          ),
        ],
      ),
    );
  }
}

class _FloatingActionButtonRiver extends StatelessWidget {
  const _FloatingActionButtonRiver({
    required this.tooltip,
    required this.icon,
    required this.routeLocation,
  });

  final String tooltip;
  final String icon;
  final String routeLocation;

  @override
  Widget build(BuildContext context) {
    final size = context.devicesize;

    return FloatingActionButton(
      backgroundColor: const Color(0xFF17CA84),
      onPressed: () => context.push(routeLocation),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFFEB710A)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image.asset(
        icon,
        height: size.height * 0.06,
      ),
    );
  }
}

class _VendaButton extends StatelessWidget {
  const _VendaButton({
    required this.text,
    required this.routeLocation,
  });

  final String text;
  final String routeLocation;

  @override
  Widget build(BuildContext context) {
    final size = context.devicesize;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      width: size.width * 0.5,
      decoration: BoxDecoration(
        color: const Color(0xFFEB710A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: () {
          context.pop();
          context.push(routeLocation);
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFFDFFFF),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class _VendaButtonDialog extends StatelessWidget {
  const _VendaButtonDialog({
    required this.tooltip,
    required this.icon,
  });

  final String tooltip;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final size = context.devicesize;

    return FloatingActionButton(
      heroTag: 'selecionar_tipo_venda',
      backgroundColor: const Color(0xFF17CA84),
      tooltip: tooltip,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFFEB710A)),
        borderRadius: BorderRadius.circular(100),
      ),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => const _VendaDialog(),
      ),
      child: Image.asset(
        icon,
        height: size.height * 0.06,
      ),
    );
  }
}

class _VendaDialog extends StatelessWidget {
  const _VendaDialog();

  @override
  Widget build(BuildContext context) {
    final size = context.devicesize;

    return AlertDialog(
      backgroundColor: const Color(0xFF006940),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 4,
          color: Color(0xFFEB710A),
        ),
        borderRadius: BorderRadius.all(Radius.circular(26)),
      ),
      title: Container(
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFEB710A),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text(
          'SELECIONAR VENDA',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFDFFFF),
            fontSize: 16,
          ),
        ),
      ),
      content: SizedBox(
        height: size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _VendaButton(
              text: 'Rua',
              routeLocation: RouteLocation.cadastroVendaRua,
            ),
            _VendaButton(
              text: 'Fiado',
              routeLocation: RouteLocation.cadastroVendaFiado,
            ),
          ],
        ),
      ),
    );
  }
}
