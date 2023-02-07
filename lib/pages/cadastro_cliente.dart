import 'package:flutter/material.dart';

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({super.key});

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {

  Size size = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF006940),
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.1,
            color: const Color(0xff910029),
            padding: const EdgeInsets.only(left: 16, top: 12),
            child: const Text(
              'Cadastro de Cliente',
              style: TextStyle(color: Color(0xffFDFFFF), fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
