import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/pages/cadastro_cliente.dart';
import 'package:vendas_gerenciamento/pages/cadastro_venda_fiado.dart';
import 'package:vendas_gerenciamento/pages/cadastro_venda_rua.dart';
import 'package:vendas_gerenciamento/pages/home_painel.dart';
import 'package:vendas_gerenciamento/pages/lista_pagamento.dart';
import 'package:vendas_gerenciamento/pages/painel_cliente.dart';
import 'package:vendas_gerenciamento/pages/pesquisa_cliente.dart';

String route = "";

routes() {
  Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomePainel(),
    '/cadastro_cliente': (context) => const CadastroCliente(),
    '/cadastro_venda_fiado': (context) => const CadastroVendaFiado(),
    '/cadastro_venda_rua': (context) => const CadastroVendaRua(),
    '/pesquisa_cliente': (context) => const PesquisaCliente(),
    '/painel_cliente': (context) => const PainelCliente(),
    '/lista_pagamento': (context) => const ListaPagamento(),
  };
  return routes;
}

Future pushNamed(BuildContext context, String routeName) {
  route = routeName;
  return Navigator.pushNamed(context, routeName);
}

Future pushReplacementNamed(BuildContext context, String routeName) {
  return Navigator.pushReplacementNamed(context, routeName);
}

bool pop<T extends Object>(BuildContext context, [T? result]) {
  return Navigator.canPop(context);
}
