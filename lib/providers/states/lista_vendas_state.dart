import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';

class ListaVendasState extends Equatable {
  final List<Venda> list;

  const ListaVendasState(this.list);

  const ListaVendasState.initial({
    this.list = const [],
  });

  ListaVendasState copyWith({List<Venda>? list}) {
    return ListaVendasState(
      list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [list];
}
