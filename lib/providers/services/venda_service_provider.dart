import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';

final vendaServiceProvider = Provider<VendaService>((ref) {
  final vendaRepository = ref.read(vendaRepositoryProvider);
  final clienteService = ref.read(clienteServiceProvider);
  final abatimentoService = ref.read(abatimentoServiceProvider);
  return VendaService(vendaRepository, clienteService, abatimentoService);
});
