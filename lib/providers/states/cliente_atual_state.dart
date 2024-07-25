import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';

class ClienteAtualState extends Equatable {
  final Cliente? cliente;
  final List<Venda> vendasDoCliente;
  final bool carregando;
  final Decimal totalEmAberto;

  const ClienteAtualState(
    this.cliente,
    this.vendasDoCliente,
    this.carregando,
    this.totalEmAberto,
  );

  const ClienteAtualState.initial({
    this.cliente,
    this.vendasDoCliente = const [],
    this.carregando = false,
    required this.totalEmAberto,
  });

  ClienteAtualState copyWith({
    Cliente? cliente,
    List<Venda>? vendasDoCliente,
    bool? carregando,
    Decimal? totalEmAberto,
  }) {
    return ClienteAtualState(
      cliente ?? this.cliente,
      vendasDoCliente ?? this.vendasDoCliente,
      carregando ?? this.carregando,
      totalEmAberto ?? this.totalEmAberto,
    );
  }

  @override
  List<Object?> get props =>
      [cliente, vendasDoCliente, carregando, totalEmAberto];
}
