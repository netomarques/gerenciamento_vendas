import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

@immutable
class ViagemKeys {
  const ViagemKeys._();

  static const String idViagem = 'id_viagem';
  static const String idBarco = BarcoKeys.idBarco;
  static const String peso = 'peso_viagem';
  static const String dateViagemChegada = 'date_viagem_chegada';
  static const String dateViagemFechada = 'date_viagem_fechada';
}
