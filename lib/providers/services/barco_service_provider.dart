import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/services/service.dart';

final barcoServiceProvider = Provider<BarcoService>((ref) {
  final barcoRepository = ref.read(barcoRepositoryProvider);
  final viagemRepository = ref.read(viagemRepositoryProvider);
  return BarcoService(barcoRepository, viagemRepository);
});
