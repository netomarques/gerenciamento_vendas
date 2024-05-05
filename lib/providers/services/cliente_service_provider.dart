import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/repository/repository.dart';
import 'package:vendas_gerenciamento/services/service.dart';

final clienteServiceProvider = Provider<ClienteService>((ref) {
  final clienteRepository = ref.watch(clienteRepositoryProvider);
  return ClienteService(clienteRepository);
});
