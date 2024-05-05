import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';

class VendaState extends Equatable {
  final List<Venda> list;

  const VendaState(this.list);

  const VendaState.initial({
    this.list = const [],
  });

  VendaState copyWith({List<Venda>? list}) {
    return VendaState(
      list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [list];
}
