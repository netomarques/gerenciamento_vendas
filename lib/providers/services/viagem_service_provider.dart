import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';

final viagemServiceProvider = Provider<ViagemService>((ref) {
  final viagemRepository = ref.read(viagemRepositoryProvider);
  final barcoRepository = ref.read(barcoRepositoryProvider);
  return ViagemService(viagemRepository, barcoRepository);
});
