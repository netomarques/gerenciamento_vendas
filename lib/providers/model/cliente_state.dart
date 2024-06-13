import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';

class ClienteState extends Equatable {
  final List<Cliente> list;

  const ClienteState(this.list);

  const ClienteState.initial({
    this.list = const [],
  });

  ClienteState copyWith({List<Cliente>? list}) {
    return ClienteState(
      list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [list];
}
