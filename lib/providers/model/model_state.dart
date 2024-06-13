import 'package:equatable/equatable.dart';

class ModelState extends Equatable {
  final List<Map<String, dynamic>> list;

  const ModelState(this.list);

  const ModelState.initial({
    this.list = const [],
  });

  ModelState copyWith({
    List<Map<String, dynamic>>? list,
  }) {
    return ModelState(
      list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [list];
}
