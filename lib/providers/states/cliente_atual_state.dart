import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';

class ClienteAtualState extends Equatable {
  final Cliente? cliente;
  final List<Venda> vendasDoCliente;
  final bool carregando;
  final double totalEmAberto;

  const ClienteAtualState(this.cliente, this.vendasDoCliente, this.carregando,
      {this.totalEmAberto = 0.0});

  const ClienteAtualState.initial({
    this.cliente,
    this.vendasDoCliente = const [],
    this.carregando = false,
    this.totalEmAberto = 0.0,
  });

  ClienteAtualState copyWith({
    Cliente? cliente,
    List<Venda>? vendasDoCliente,
    bool? carregando,
    double? totalEmAberto,
  }) {
    return ClienteAtualState(
      cliente ?? this.cliente,
      vendasDoCliente ?? this.vendasDoCliente,
      carregando ?? this.carregando,
      totalEmAberto: totalEmAberto ?? this.totalEmAberto,
    );
  }

  @override
  List<Object?> get props =>
      [cliente, vendasDoCliente, carregando, totalEmAberto];
}
