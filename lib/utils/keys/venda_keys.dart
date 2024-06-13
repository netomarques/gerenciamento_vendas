import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

@immutable
class VendaKeys {
  const VendaKeys._();

  static const String idVenda = 'id_venda';
  static const String dateVenda = 'date_venda';
  static const String preco = 'preco';
  static const String quantidade = 'quantidade';
  static const String desconto = 'desconto';
  static const String total = 'total';
  static const String isFiado = 'fiado';
  static const String isAberto = 'is_aberto';
  static const String totalEmAberto = 'total_em_aberto';
  static const String idCliente = ClienteKeys.idCliente;
}
