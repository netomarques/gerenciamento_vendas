import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';

final vendaServiceProvider = Provider<VendaService>((ref) {
  final vendaRepository = ref.watch(vendaRepositoryProvider);
  final clienteService = ref.watch(clienteServiceProvider);
  return VendaService(vendaRepository, clienteService);
});
