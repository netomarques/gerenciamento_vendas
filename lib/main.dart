import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/pages/cadastro_cliente.dart';
import 'package:vendas_gerenciamento/pages/home_painel.dart';
import 'package:vendas_gerenciamento/utils/build_material_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerenciamento de vendas',
      theme: ThemeData(
        primarySwatch: BuildMaterialColor(
          const Color(0xFF006940),
        ),
        scaffoldBackgroundColor: const Color(0xFFFDFFFF),
      ),
      home: const CadastroCliente(),
    );
  }
}
