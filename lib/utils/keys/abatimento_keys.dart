import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

@immutable
class AbatimentoKeys {
  const AbatimentoKeys._();

  static const String idAbatimento = 'id_abatimento';
  static const String idVenda = VendaKeys.idVenda;
  static const String valor = 'valor_abatido';
  static const String dateAbatimento = 'date_abatimento';
}
