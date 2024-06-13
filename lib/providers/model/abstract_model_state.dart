import 'package:equatable/equatable.dart';

abstract class AbstractModelState extends Equatable {
  abstract final List<Map<String, dynamic>> list;

  AbstractModelState copyWith({
    List<Map<String, dynamic>>? list,
  });

  @override
  List<Object?> get props => [list];
}
