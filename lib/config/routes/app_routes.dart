import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/pages/cadastro_cliente.dart';
import 'package:vendas_gerenciamento/pages/home_painel.dart';
import 'package:vendas_gerenciamento/pages/lista_pagamento.dart';
import 'package:vendas_gerenciamento/pages/pesquisa_cliente.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomePainel.builder,
  ),
  GoRoute(
    path: RouteLocation.pesquisaCliente,
    parentNavigatorKey: navigationKey,
    builder: PesquisaCliente.builder,
  ),
  GoRoute(
    path: RouteLocation.cadastroCliente,
    parentNavigatorKey: navigationKey,
    builder: CadastroCliente.builder,
  ),
  GoRoute(
    path: RouteLocation.listarPagamentos,
    parentNavigatorKey: navigationKey,
    builder: ListaPagamento.builder,
  ),
];
