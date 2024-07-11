import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final listaVendasProvider =
    StateNotifierProvider<ListaVendasNotifier, ListaVendasState>((ref) {
  final service = ref.watch(vendaServiceProvider);
  return ListaVendasNotifier(service);
});
