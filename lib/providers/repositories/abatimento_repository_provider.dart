import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';

final abatimentoRepositoryProvider = Provider.autoDispose<AbatimentoRepositoryImpl>((ref) {
  final connection = ref.read(connectionProvider);
  return AbatimentoRepositoryImpl(connection);
});
