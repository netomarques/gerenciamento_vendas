import 'package:vendas_gerenciamento/api/abatimentos_api.dart';
import 'package:vendas_gerenciamento/model/abatimento.dart';
import 'package:vendas_gerenciamento/model/abatimentos.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';

class Venda {
  final int id;
  final double quantidade;
  final double preco;
  final DateTime data;
  final Cliente cliente;

  Venda(
      {required this.id,
      required this.quantidade,
      required this.preco,
      required this.data,
      required this.cliente});

  bool isFiado() {
    return cliente.id != 1 ? true : false;
  }

  List<Abatimento> abatimentosVenda() {
    List<Abatimento> abatimentosCopia;
    abatimentosCopia = abatimentos.values
        .where((abatimento) => abatimento.idVenda == id)
        .toList();

    return abatimentosCopia;
  }

  List<Abatimento> getAbatimentosVenda() {
    return AbatimentosApi().abatimentosVenda(id);
  }

  bool isOpen() {
    bool isOpen;
    List<Abatimento> abatimentosVenda = this.abatimentosVenda();

    if (abatimentosVenda.isEmpty) {
      isOpen = true;
    } else {
      double totalAbatido = 0.0;
      for (Abatimento abatimento in abatimentosVenda) {
        totalAbatido = abatimento.valor + totalAbatido;
      }

      totalAbatido == preco * quantidade ? isOpen = false : isOpen = true;
    }

    return isOpen;
  }

  double getTotalEmAberto() {
    double valorAberto = 0.0;
    double totalAbatido = 0.0;

    List<Abatimento> abatimentosVenda = getAbatimentosVenda();

    for (Abatimento abatimento in abatimentosVenda) {
      totalAbatido = abatimento.valor + totalAbatido;
    }

    valorAberto = preco * quantidade - totalAbatido;

    return valorAberto;
  }

  double totalEmAberto() {
    double valorAberto = 0.0;
    double totalAbatido = 0.0;

    List<Abatimento> abatimentosVenda = this.abatimentosVenda();
    for (Abatimento abatimento in abatimentosVenda) {
      totalAbatido = abatimento.valor + totalAbatido;
    }

    valorAberto = preco * quantidade - totalAbatido;

    return valorAberto;
  }

  double getTotal() {
    return preco * quantidade;
  }
}
