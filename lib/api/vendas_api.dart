import 'package:vendas_gerenciamento/model/abatimento.dart';
import 'package:vendas_gerenciamento/model/clientes.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:intl/intl.dart';

class VendasApi {
  static final VendasApi _instancia = VendasApi._();

  factory VendasApi() {
    return _instancia;
  }

  VendasApi._();

  final Map<String, Venda> _vendas = {
    '1': Venda(
      id: 1,
      quantidade: 24.60,
      preco: 12.00,
      data: DateTime.now(),
      cliente: clientes.values.elementAt(0),
      desconto: 0.2,
    ),
    '2': Venda(
      id: 2,
      quantidade: 299.00,
      preco: 12.00,
      data: DateTime(2023, 1, 1),
      cliente: clientes.values.elementAt(1),
      desconto: 0.0,
    ),
    '3': Venda(
      id: 3,
      quantidade: 58.00,
      preco: 12.00,
      data: DateTime(2023, 2, 15),
      cliente: clientes.values.elementAt(0),
      desconto: 0.0,
    ),
    '4': Venda(
      id: 4,
      quantidade: 81.00,
      preco: 12.00,
      data: DateTime(2023, 1, 28),
      cliente: clientes.values.elementAt(0),
      desconto: 0.0,
    ),
    '5': Venda(
      id: 5,
      quantidade: 80.00,
      preco: 12.00,
      data: DateTime(2023, 2, 5),
      cliente: clientes.values.elementAt(1),
      desconto: 0.0,
    ),
    '6': Venda(
      id: 6,
      quantidade: 4.50,
      preco: 12.00,
      data: DateTime(2023, 2, 19),
      cliente: clientes.values.elementAt(3),
      desconto: 0.0,
    ),
    '7': Venda(
      id: 7,
      quantidade: 4.50,
      preco: 12.00,
      data: DateTime(2023, 1, 31),
      cliente: clientes.values.elementAt(0),
      desconto: 0.0,
    ),
    '8': Venda(
      id: 8,
      quantidade: 150.00,
      preco: 12.00,
      data: DateTime(2023, 2, 14),
      cliente: clientes.values.elementAt(3),
      desconto: 0.0,
    ),
    '9': Venda(
      id: 9,
      quantidade: 48.00,
      preco: 12.00,
      data: DateTime(2023, 2, 22),
      cliente: clientes.values.elementAt(0),
      desconto: 0.0,
    ),
    '10': Venda(
      id: 10,
      quantidade: 85.00,
      preco: 12.00,
      data: DateTime(2023, 2, 7),
      cliente: clientes.values.elementAt(4),
      desconto: 0.0,
    ),
    '11': Venda(
      id: 11,
      quantidade: 26.00,
      preco: 12.00,
      data: DateTime(2023, 2, 19),
      cliente: clientes.values.elementAt(5),
      desconto: 0.0,
    ),
    '12': Venda(
      id: 12,
      quantidade: 13.50,
      preco: 12.00,
      data: DateTime(2023, 1, 27),
      cliente: clientes.values.elementAt(4),
      desconto: 0.0,
    ),
    '13': Venda(
      id: 13,
      quantidade: 4.70,
      preco: 12.00,
      data: DateTime(2023, 2, 10),
      cliente: clientes.values.elementAt(4),
      desconto: 0.0,
    ),
    '14': Venda(
      id: 14,
      quantidade: 8.70,
      preco: 12.00,
      data: DateTime(2023, 1, 31),
      cliente: clientes.values.elementAt(5),
      desconto: 0.0,
    ),
    '15': Venda(
      id: 15,
      quantidade: 67.00,
      preco: 12.00,
      data: DateTime(2023, 2, 15),
      cliente: clientes.values.elementAt(5),
      desconto: 0.0,
    ),
  };

  final Map<String, Abatimento> _abatimentos = {
    '1': Abatimento(
      idVenda: 1,
      valor: 295.20,
      dateAbatimento: DateTime.now(),
    ),
    '2': Abatimento(
      idVenda: 2,
      valor: 1200.00,
      dateAbatimento: DateTime(2023, 1, 1),
    ),
    '3': Abatimento(
      idVenda: 2,
      valor: 800.00,
      dateAbatimento: DateTime(2023, 1, 8),
    ),
    '4': Abatimento(
      idVenda: 3,
      valor: 696.00,
      dateAbatimento: DateTime(2023, 2, 15),
    ),
    '5': Abatimento(
      idVenda: 4,
      valor: 972.00,
      dateAbatimento: DateTime(2023, 1, 28),
    ),
    '6': Abatimento(
      idVenda: 5,
      valor: 480.00,
      dateAbatimento: DateTime(2023, 2, 15),
    ),
    '7': Abatimento(
      idVenda: 5,
      valor: 480.00,
      dateAbatimento: DateTime(2023, 2, 18),
    ),
    '8': Abatimento(
      idVenda: 6,
      valor: 54.00,
      dateAbatimento: DateTime(2023, 3, 5),
    ),
    '9': Abatimento(
      idVenda: 7,
      valor: 54.00,
      dateAbatimento: DateTime(2023, 1, 31),
    ),
    '10': Abatimento(
      idVenda: 10,
      valor: 350.00,
      dateAbatimento: DateTime(2023, 2, 13),
    ),
    '11': Abatimento(
      idVenda: 9,
      valor: 576.00,
      dateAbatimento: DateTime(2023, 2, 22),
    ),
    '12': Abatimento(
      idVenda: 10,
      valor: 240.00,
      dateAbatimento: DateTime(2023, 2, 21),
    ),
    '13': Abatimento(
      idVenda: 8,
      valor: 900.00,
      dateAbatimento: DateTime(2023, 2, 22),
    ),
    '14': Abatimento(
      idVenda: 11,
      valor: 100.00,
      dateAbatimento: DateTime(2023, 2, 28),
    ),
    '15': Abatimento(
      idVenda: 13,
      valor: 18.80,
      dateAbatimento: DateTime(2023, 2, 12),
    ),
    '16': Abatimento(
      idVenda: 13,
      valor: 18.80,
      dateAbatimento: DateTime(2023, 2, 14),
    ),
    '17': Abatimento(
      idVenda: 15,
      valor: 400.00,
      dateAbatimento: DateTime(2023, 2, 25),
    ),
  };

  Map<String, Venda> get vendas => _vendas;

  Map<String, Abatimento> get abatimentos => _abatimentos;

  Future<List<Venda>> ordenarListaPorDataDecrescente(
      DateTime start, DateTime end) async {
    final DateFormat dateFormatBanco = DateFormat('dd/MM/yyyy');

    start = dateFormatBanco
        .parse(dateFormatBanco.format(start))
        .subtract(const Duration(days: 1));

    end = dateFormatBanco
        .parse(dateFormatBanco.format(end))
        .add(const Duration(days: 1));

    var sortedKeys = _vendas.keys.toList(growable: false)
      ..sort((k1, k2) => _vendas[k2]!.data.isAfter(_vendas[k1]!.data) ? 1 : -1);

    Map<String, Venda> vendasFiltradas = <String, Venda>{};
    vendasFiltradas = {for (var key in sortedKeys) key: _vendas[key]!};

    return vendasFiltradas.values
        .where((venda) => venda.data.isAfter(start) && venda.data.isBefore(end))
        .toList();
  }

  Future<Map<String, dynamic>> resumoVendas(List<Venda> vendas) async {
    int quantVendaRua, quantVendaFiado;
    double totalVendaRua, totalVendaFiado;
    // NumberFormat numberFormat = NumberFormat('##');

    quantVendaRua = quantVendaFiado = 0;
    totalVendaRua = totalVendaFiado = 0.0;

    for (Venda venda in vendas) {
      switch (venda.isFiado()) {
        case true:
          quantVendaFiado += 1;
          totalVendaFiado += venda.total();
          break;
        case false:
          quantVendaRua += 1;
          totalVendaRua += venda.total();
          break;
      }
    }

    Map<String, dynamic> resumo = <String, dynamic>{
      "Fiado": {"Total": totalVendaFiado, "Quantidade": quantVendaFiado},
      "Rua": {"Total": totalVendaRua, "Quantidade": quantVendaRua},
      "Vendas": {
        "Total": totalVendaRua + totalVendaFiado,
        "Quantidade": quantVendaRua + quantVendaFiado,
      },
    };

    return resumo;
  }

  Future<List<Venda>> vendasCliente(
      int idCliente, DateTime start, DateTime end) async {
    List<Venda> vendas = await ordenarListaPorDataDecrescente(start, end);

    return vendas.where((venda) => venda.cliente.id == idCliente).toList();
  }

  Future<double> valorTotalEmAbertoPorCliente(List<Venda> vendas) async {
    double totalAberto = 0.0;

    for (Venda venda in vendas) {
      totalAberto += venda.totalEmAberto();
    }

    return totalAberto;
  }

  void adicionarVenda(Venda venda) {
    _vendas[venda.id.toString()] = venda;
  }

  void removerVenda(int idVenda) {
    _vendas.remove(idVenda.toString());
  }

  int gerarId() {
    return _vendas.values.last.id + 1;
  }

  List<Abatimento> abatimentosVenda(int idVenda) {
    List<Abatimento> abatimentosVenda = _abatimentos.values
        .where((abatimento) => abatimento.idVenda == idVenda)
        .toList();

    abatimentosVenda
        .sort((a, b) => b.dateAbatimento.compareTo(a.dateAbatimento));

    return abatimentosVenda;
  }
}
