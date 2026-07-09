import 'package:flutter_riverpod/legacy.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final buttonProvider =
    StateNotifierProvider.autoDispose<ButtonNotifier, ButtonState>((ref) {
  return ButtonNotifier();
});
