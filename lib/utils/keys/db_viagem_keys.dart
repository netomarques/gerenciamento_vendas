import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

@immutable
class DbViagemKeys {
  const DbViagemKeys._();

  static const String tableName = 'Viagens';
  static const String idColuna = ViagemKeys.idViagem;
  static const String idBarcoColuna = BarcoKeys.idBarco;
  static const String pesoColuna = ViagemKeys.peso;
  static const String dateViagemChegadaColuna = ViagemKeys.dateViagemChegada;
  static const String dateViagemFechadaColuna = ViagemKeys.dateViagemFechada;
}
