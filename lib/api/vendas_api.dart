import 'package:vendas_gerenciamento/model/clientes.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:intl/intl.dart';

class VendasApi {
  final Map<String, Venda> _vendas = {
    '1': Venda(
      id: 1,
      quantidade: 24.60,
      preco: 12.00,
      data: DateTime.now(),
      cliente: clientes.values.elementAt(0),
    ),
    '2': Venda(
      id: 2,
      quantidade: 299.00,
      preco: 12.00,
      data: DateTime(2023, 1, 1),
      cliente: clientes.values.elementAt(1),
    ),
    '3': Venda(
      id: 3,
      quantidade: 58.00,
      preco: 12.00,
      data: DateTime(2023, 2, 15),
      cliente: clientes.values.elementAt(0),
    ),
    '4': Venda(
      id: 4,
      quantidade: 81.00,
      preco: 12.00,
      data: DateTime(2023, 1, 28),
      cliente: clientes.values.elementAt(0),
    ),
    '5': Venda(
      id: 5,
      quantidade: 80.00,
      preco: 12.00,
      data: DateTime(2023, 2, 5),
      cliente: clientes.values.elementAt(1),
    ),
    '6': Venda(
      id: 6,
      quantidade: 4.50,
      preco: 12.00,
      data: DateTime(2023, 2, 19),
      cliente: clientes.values.elementAt(3),
    ),
    '7': Venda(
      id: 7,
      quantidade: 4.50,
      preco: 12.00,
      data: DateTime(2023, 1, 31),
      cliente: clientes.values.elementAt(0),
    ),
    '8': Venda(
      id: 8,
      quantidade: 150.00,
      preco: 12.00,
      data: DateTime(2023, 2, 14),
      cliente: clientes.values.elementAt(3),
    ),
    '9': Venda(
      id: 9,
      quantidade: 48.00,
      preco: 12.00,
      data: DateTime(2023, 2, 22),
      cliente: clientes.values.elementAt(0),
    ),
    '10': Venda(
      id: 10,
      quantidade: 85.00,
      preco: 12.00,
      data: DateTime(2023, 2, 7),
      cliente: clientes.values.elementAt(4),
    ),
    '11': Venda(
      id: 11,
      quantidade: 26.00,
      preco: 12.00,
      data: DateTime(2023, 2, 19),
      cliente: clientes.values.elementAt(5),
    ),
    '12': Venda(
      id: 12,
      quantidade: 13.50,
      preco: 12.00,
      data: DateTime(2023, 1, 27),
      cliente: clientes.values.elementAt(4),
    ),
    '13': Venda(
      id: 13,
      quantidade: 4.70,
      preco: 12.00,
      data: DateTime(2023, 2, 10),
      cliente: clientes.values.elementAt(4),
    ),
    '14': Venda(
      id: 14,
      quantidade: 8.70,
      preco: 12.00,
      data: DateTime(2023, 1, 31),
      cliente: clientes.values.elementAt(5),
    ),
    '15': Venda(
      id: 15,
      quantidade: 67.00,
      preco: 12.00,
      data: DateTime(2023, 2, 15),
      cliente: clientes.values.elementAt(5),
    ),
  };

  get vendas async => _vendas;

  Future<Map<String, Venda>> ordenarListaPorDataDecrescente(
      DateTime start, DateTime end) async {
    final DateFormat dateFormatBanco = DateFormat('dd/MM/yyyy');

    String startText = dateFormatBanco.format(start);
    String endText = dateFormatBanco.format(end);

    start = dateFormatBanco.parse(startText);
    end = dateFormatBanco.parse(endText);

    Map<String, Venda> vendasFiltradas = <String, Venda>{};
    Map<String, Venda> copiaVendas = Map<String, Venda>.from(_vendas);

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

  Future<List<Venda>> vendasCliente(
      int idCliente, DateTime start, DateTime end) async {
    Map<String, Venda> vendasCopia =
        await ordenarListaPorDataDecrescente(start, end);
    vendasCopia.removeWhere((key, venda) => venda.cliente.id != idCliente);

    List<Venda> vendasCliente = vendasCopia.values.toList();

    return vendasCliente;
  }

  Future<double> valorTotalEmAbertoPorCliente(List<Venda> vendas) async {
    double totalAberto = 0.0;

    for (Venda venda in vendas) {
      totalAberto = venda.totalEmAberto() + totalAberto;
    }

    return totalAberto;
  }
}
