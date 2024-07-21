import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final buttonProvider =
    StateNotifierProvider.autoDispose<ButtonNotifier, ButtonState>((ref) {
  return ButtonNotifier();
});
