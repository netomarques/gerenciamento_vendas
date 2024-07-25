import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final clienteAtualProvider = StateNotifierProvider.autoDispose
    .family<ClienteAtualNotifier, ClienteAtualState, Cliente>((ref, cliente) {
  final clienteService = ref.read(clienteServiceProvider);
  final vendaService = ref.read(vendaServiceProvider);
  return ClienteAtualNotifier(clienteService, vendaService, cliente);
});
