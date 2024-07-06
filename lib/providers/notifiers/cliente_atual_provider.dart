import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final clienteAtualProvider =
    StateNotifierProvider.autoDispose.family<ClienteAtualNotifier, ClienteAtualState, int>(
        (ref, id) {
  final clientes = ref.read(clientesProvider).list;
  final cliente = clientes.firstWhere((cliente) => cliente.id == id);
  final clienteService = ref.read(clienteServiceProvider);
  final vendaService = ref.read(vendaServiceProvider);
  return ClienteAtualNotifier(clienteService, vendaService, cliente);
});
