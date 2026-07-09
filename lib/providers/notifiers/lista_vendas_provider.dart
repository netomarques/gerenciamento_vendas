import 'package:flutter_riverpod/legacy.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final listaVendasProvider =
    StateNotifierProvider<ListaVendasNotifier, ListaVendasState>((ref) {
  final service = ref.watch(vendaServiceProvider);
  return ListaVendasNotifier(service);
});
