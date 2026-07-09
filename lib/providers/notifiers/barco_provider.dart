import 'package:flutter_riverpod/legacy.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final barcoProvider = StateNotifierProvider.autoDispose
    .family<BarcoNotifier, BarcoState, int>((ref, idBarco) {
  final service = ref.watch(barcoServiceProvider);
  return BarcoNotifier(service, idBarco);
});
