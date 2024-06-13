import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

@immutable
class RouteLocation {
  const RouteLocation._();

  static String get home => '/';
  static String get cadastroCliente => '/cadastro_cliente';
  static String get alterarCliente => '/alterar_cliente';
  static String get cadastroVendaFiado => '/cadastro_venda_fiado';
  static String get cadastroVendaRua => '/cadastro_venda_rua';
  static String get pesquisaCliente => '/pesquisa_cliente';
  static String get painelCliente => '/painel_cliente';
  static String get listarPagamentos => '/lista_pagamento';
}
