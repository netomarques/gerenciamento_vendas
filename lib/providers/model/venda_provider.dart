import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/providers/services/services.dart';

final vendaProvider = StateNotifierProvider<VendaNotifier, VendaState>((ref) {
  // final repository = ref.watch(vendaRepositoryProvider);
  final service = ref.watch(vendaServiceProvider);
  return VendaNotifier(service);
});
