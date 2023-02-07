import 'package:flutter/material.dart';

class NavButtonsFloating extends StatefulWidget {
  const NavButtonsFloating({super.key});

  @override
  State<NavButtonsFloating> createState() => _NavButtonsFloatingState();
}

class _NavButtonsFloatingState extends State<NavButtonsFloating> {
  Size size = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return _bottonfloatinNavigator();
  }

  _bottonfloatinNavigator() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF006940),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(right: 30, left: 30, bottom: 2),
      width: size.width * 0.8,
      height: size.height * 0.095,
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            backgroundColor: const Color(0xff910029),
            tooltip: 'Clientes',
            onPressed: () {},
            child: const Icon(Icons.people),
          ),
          FloatingActionButton(
            backgroundColor: const Color(0xff910029),
            tooltip: 'Venda',
            onPressed: () {},
            child: const Icon(
              Icons.add_shopping_cart,
            ),
          ),
          FloatingActionButton(
            backgroundColor: const Color(0xff910029),
            tooltip: 'Pesquisa de clientes',
            onPressed: () {},
            child: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
