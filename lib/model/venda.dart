import 'package:vendas_gerenciamento/api/vendas_api.dart';
import 'package:vendas_gerenciamento/model/abatimento.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';

class Venda {
  int id;
  double quantidade;
  double preco;
  double desconto;
  DateTime data;
  Cliente cliente;

  Venda(
      {required this.id,
      required this.quantidade,
      required this.preco,
      required this.data,
      required this.cliente,
      required this.desconto});

  bool isFiado() {
    return cliente.id != 1 ? true : false;
  }

  double total() {
    return (quantidade * preco) - desconto;
  }

  List<Abatimento> getAbatimentosVenda() {
    return VendasApi().abatimentosVenda(id);
  }

  bool isOpen() {
    bool isOpen;
    List<Abatimento> abatimentosVenda = getAbatimentosVenda();

    if (abatimentosVenda.isEmpty) {
      isOpen = true;
    } else {
      double totalAbatido = 0.0;
      for (Abatimento abatimento in abatimentosVenda) {
        totalAbatido += abatimento.valor;
      }

      totalAbatido == total() ? isOpen = false : isOpen = true;
    }

    return isOpen;
  }

  double totalEmAberto() {
    double totalAbatido = 0.0;

    List<Abatimento> abatimentosVenda = getAbatimentosVenda();
    for (Abatimento abatimento in abatimentosVenda) {
      totalAbatido = abatimento.valor + totalAbatido;
    }

    return total() - totalAbatido;
  }
}
