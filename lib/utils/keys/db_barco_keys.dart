import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

@immutable
class DbBarcoKeys {
  const DbBarcoKeys._();

  static const String tableName = 'Barcos';
  static const String idColuna = BarcoKeys.idBarco;
  static const String nomeColuna = BarcoKeys.nome;
}
