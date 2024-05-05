import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

@immutable
class DbAbatimentoKeys {
  const DbAbatimentoKeys._();

  static const String tableName = 'Abatimentos';
  static const String idAbatimentoColuna = AbatimentoKeys.idAbatimento;
  static const String idVendaColuna = AbatimentoKeys.idVenda;
  static const String valorColuna = AbatimentoKeys.valor;
  static const String dateAbatimentoColuna = AbatimentoKeys.dateAbatimento;
}
