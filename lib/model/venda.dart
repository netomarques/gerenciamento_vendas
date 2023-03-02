import 'package:vendas_gerenciamento/model/cliente.dart';

class Venda {
  final double quantidade;
  final double preco;
  final DateTime data;
  final Cliente cliente;

  Venda(
      {required this.quantidade,
      required this.preco,
      required this.data,
      required this.cliente});
}
