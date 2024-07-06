import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/pages/pages.dart';

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
    path: RouteLocation.alterarCliente,
    parentNavigatorKey: navigationKey,
    builder: AlterarCliente.builder,
  ),
  GoRoute(
    path: RouteLocation.painelCliente,
    parentNavigatorKey: navigationKey,
    builder: PainelCliente.builder,
  ),
  GoRoute(
    path: RouteLocation.listarPagamentos,
    parentNavigatorKey: navigationKey,
    builder: ListaPagamento.builder,
  ),
];
