import 'package:flutter_riverpod/legacy.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final vendaProvider = StateNotifierProvider.autoDispose
    .family<VendaNotifier, VendaState, Venda>((ref, venda) {
  final service = ref.read(vendaServiceProvider);
  return VendaNotifier(service, venda);
});
