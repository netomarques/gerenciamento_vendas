import 'package:vendas_gerenciamento/model/clientes.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:intl/intl.dart';

final Map<String, Venda> vendas = {
  '1': Venda(
    quantidade: 24.60,
    preco: 12.00,
    data: DateTime.now(),
    cliente: clientes.values.elementAt(0),
  ),
  '2': Venda(
    quantidade: 299.00,
    preco: 12.00,
    data: DateTime(2023, 1, 1),
    cliente: clientes.values.elementAt(1),
  ),
  '3': Venda(
    quantidade: 58.00,
    preco: 12.00,
    data: DateTime(2023, 2, 15),
    cliente: clientes.values.elementAt(0),
  ),
  '4': Venda(
    quantidade: 81.00,
    preco: 12.00,
    data: DateTime(2023, 1, 28),
    cliente: clientes.values.elementAt(0),
  ),
  '5': Venda(
    quantidade: 80.00,
    preco: 12.00,
    data: DateTime(2023, 2, 5),
    cliente: clientes.values.elementAt(1),
  ),
  '6': Venda(
    quantidade: 4.50,
    preco: 12.00,
    data: DateTime(2023, 2, 19),
    cliente: clientes.values.elementAt(3),
  ),
  '7': Venda(
    quantidade: 4.50,
    preco: 12.00,
    data: DateTime(2023, 1, 31),
    cliente: clientes.values.elementAt(0),
  ),
  '8': Venda(
    quantidade: 150.00,
    preco: 12.00,
    data: DateTime(2023, 2, 14),
    cliente: clientes.values.elementAt(3),
  ),
  '9': Venda(
    quantidade: 48.00,
    preco: 12.00,
    data: DateTime(2023, 2, 22),
    cliente: clientes.values.elementAt(0),
  ),
  '10': Venda(
    quantidade: 85.00,
    preco: 12.00,
    data: DateTime(2023, 2, 7),
    cliente: clientes.values.elementAt(4),
  ),
  '11': Venda(
    quantidade: 26.00,
    preco: 12.00,
    data: DateTime(2023, 2, 19),
    cliente: clientes.values.elementAt(5),
  ),
  '12': Venda(
    quantidade: 13.50,
    preco: 12.00,
    data: DateTime(2023, 1, 27),
    cliente: clientes.values.elementAt(4),
  ),
  '13': Venda(
    quantidade: 4.70,
    preco: 12.00,
    data: DateTime(2023, 2, 10),
    cliente: clientes.values.elementAt(4),
  ),
  '14': Venda(
    quantidade: 8.70,
    preco: 12.00,
    data: DateTime(2023, 1, 31),
    cliente: clientes.values.elementAt(5),
  ),
  '15': Venda(
    quantidade: 67.00,
    preco: 12.00,
    data: DateTime(2023, 2, 15),
    cliente: clientes.values.elementAt(5),
  ),
};

double calcularTotal(Map<String, Venda> vendas) {
  double somaTotal = 0.0;
  vendas.forEach((key, venda) {
    somaTotal = (venda.quantidade * venda.preco) + somaTotal;
  });

  return somaTotal;
}

Map<String, Venda> ordenarListaPorDataDecrescente(
    DateTime start, DateTime end) {
  final DateFormat dateFormatBanco = DateFormat('dd/MM/yyyy');

  String startText = dateFormatBanco.format(start);
  String endText = dateFormatBanco.format(end);

  start = dateFormatBanco.parse(startText);
  end = dateFormatBanco.parse(endText);

  Map<String, Venda> vendasFiltradas = <String, Venda>{};
  Map<String, Venda> copiaVendas = Map<String, Venda>.from(vendas);

  DateTime startDate = start.subtract(const Duration(days: 1));
  DateTime endDate = end.add(const Duration(days: 1));

  copiaVendas.removeWhere((key, value) => !value.data.isAfter(startDate));
  copiaVendas.removeWhere((key, value) => !value.data.isBefore(endDate));

  var sortedKeys = copiaVendas.keys.toList(growable: false)
    ..sort((k1, k2) =>
        copiaVendas[k2]!.data.isAfter(copiaVendas[k1]!.data) ? 1 : -1);

  vendasFiltradas = {for (var key in sortedKeys) key: copiaVendas[key]!};

  return vendasFiltradas;
}
