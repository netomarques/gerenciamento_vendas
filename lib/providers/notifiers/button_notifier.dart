import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

class ButtonNotifier extends StateNotifier<ButtonState> {
  ButtonNotifier() : super(const ButtonState.initial());

  setCarregando(bool carregando) {
    state = state.copyWith(carregando: carregando);
  }
}
