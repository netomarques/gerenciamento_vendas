import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

@immutable
class DbClienteKeys {
  const DbClienteKeys._();

  static const String tableName = 'Clientes';
  static const String idColuna = ClienteKeys.idCliente;
  static const String nomeColuna = ClienteKeys.nome;
  static const String telefoneColuna = ClienteKeys.telefone;
  static const String cpfcnpjColuna = ClienteKeys.cpfcnpj;
}
