import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';

class ClientesState extends Equatable {
  final List<Cliente> list;
  final int limit;
  final bool carregando;
  final bool filtroPorNome;

  const ClientesState(
    this.list,
    this.limit,
    this.carregando,
    this.filtroPorNome,
  );

  const ClientesState.initial({
    this.list = const [],
    this.limit = 10,
    this.carregando = false,
    this.filtroPorNome = false,
  });

  ClientesState copyWith({
    List<Cliente>? list,
    int? limit,
    bool? carregando,
    bool? filtroPorNome,
  }) {
    return ClientesState(
      list ?? this.list,
      limit ?? this.limit,
      carregando ?? this.carregando,
      filtroPorNome ?? this.filtroPorNome,
    );
  }

  @override
  List<Object?> get props => [list, limit, carregando, filtroPorNome];
}
