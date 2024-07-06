import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final vendaProvider = StateNotifierProvider<VendaNotifier, VendaState>((ref) {
  // final repository = ref.watch(vendaRepositoryProvider);
  final service = ref.watch(vendaServiceProvider);
  return VendaNotifier(service);
});
