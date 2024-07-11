import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final vendaProvider = StateNotifierProvider.autoDispose
    .family<VendaNotifier, VendaState, int>((ref, id) {
  final service = ref.read(vendaServiceProvider);
  return VendaNotifier(service, id);
});
