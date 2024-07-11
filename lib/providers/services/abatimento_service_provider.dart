import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';

final abatimentoServiceProvider =
    Provider.autoDispose<AbatimentoService>((ref) {
  final abatimentoRepository = ref.read(abatimentoRepositoryProvider);
  return AbatimentoService(abatimentoRepository);
});
