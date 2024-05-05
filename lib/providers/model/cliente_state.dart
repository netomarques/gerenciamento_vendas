import 'package:equatable/equatable.dart';

class ClienteState extends Equatable {
  final List<Map<String, dynamic>> list;

  const ClienteState(this.list);

  const ClienteState.initial({
    this.list = const [],
  });

  ClienteState copyWith({List<Map<String, dynamic>>? list}) {
    return ClienteState(
      list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [list];
}
