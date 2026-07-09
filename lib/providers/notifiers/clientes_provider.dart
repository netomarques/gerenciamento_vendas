import 'package:flutter_riverpod/legacy.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final clientesProvider =
    StateNotifierProvider.autoDispose<ClientesNotifier, ClientesState>((ref) {
  final service = ref.read(clienteServiceProvider);
  return ClientesNotifier(service);
});
