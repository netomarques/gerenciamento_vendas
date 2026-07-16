import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

class ButtonNotifier extends Notifier<ButtonState> {
  @override
  ButtonState build() {
    return const ButtonState.initial();
  }

  void setCarregando(bool carregando) {
    state = state.copyWith(carregando: carregando);
  }
}
