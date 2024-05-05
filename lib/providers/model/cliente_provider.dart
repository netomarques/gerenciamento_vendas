import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/repository/repository.dart';

final clienteProvider =
    StateNotifierProvider<ClienteNotifier, ClienteState>((ref) {
  final repository = ref.watch(clienteRepositoryProvider);
  return ClienteNotifier(repository);
});
