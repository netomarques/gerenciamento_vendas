import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/providers/services/cliente_service_provider.dart';
import 'package:vendas_gerenciamento/repository/repository.dart';

final clienteProvider =
    StateNotifierProvider<ClienteNotifier, ClienteState>((ref) {
  final service = ref.watch(clienteServiceProvider);
  return ClienteNotifier(service);
});
