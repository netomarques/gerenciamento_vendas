import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';

final clienteServiceProvider = Provider<ClienteService>((ref) {
  final clienteRepository = ref.read(clienteRepositoryProvider);
  return ClienteService(clienteRepository);
});
