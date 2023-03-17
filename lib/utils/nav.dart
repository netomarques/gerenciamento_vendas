import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/pages/cadastro_cliente.dart';
import 'package:vendas_gerenciamento/pages/cadastro_venda_fiado.dart';
import 'package:vendas_gerenciamento/pages/cadastro_venda_rua.dart';
import 'package:vendas_gerenciamento/pages/home_painel.dart';
import 'package:vendas_gerenciamento/pages/lista_pagamento.dart';
import 'package:vendas_gerenciamento/pages/painel_cliente.dart';
import 'package:vendas_gerenciamento/pages/pesquisa_cliente.dart';

String _route = "";

routes() {
  Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomePainel(),
    '/cadastro_cliente': (context) => const CadastroCliente(),
    '/cadastro_venda_fiado': (context) => const CadastroVendaFiado(),
    '/cadastro_venda_rua': (context) => const CadastroVendaRua(),
    '/pesquisa_cliente': (context) => const PesquisaCliente(),
    '/painel_cliente': (context) {
      final Map<String, dynamic> argumnets =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final Cliente cliente = argumnets['cliente'] as Cliente;

      return PainelCliente(cliente);
    },
    '/lista_pagamento': (context) {
      final Map<String, dynamic> argumnets =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final Venda venda = argumnets['venda'] as Venda;

      return ListaPagamento(venda);
    },
  };
  return routes;
}

Future pushNamed(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) {
  _route = routeName;
  return Navigator.pushNamed(context, routeName, arguments: arguments);
}

Future pushReplacementNamed(BuildContext context, String routeName) {
  _route = routeName;
  return Navigator.pushReplacementNamed(context, routeName);
}

bool pop<T extends Object>(BuildContext context, [T? result]) {
  return Navigator.canPop(context);
}
