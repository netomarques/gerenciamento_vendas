import 'package:equatable/equatable.dart';

class ButtonState extends Equatable {
  final bool carregando;

  const ButtonState(
    this.carregando,
  );

  const ButtonState.initial({
    this.carregando = false,
  });

  ButtonState copyWith({
    bool? carregando,
  }) {
    return ButtonState(
      carregando ?? this.carregando,
    );
  }

  @override
  List<Object?> get props => [carregando];
}
