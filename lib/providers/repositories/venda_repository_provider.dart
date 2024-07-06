import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';

final vendaRepositoryProvider = Provider<VendaRepositoryImpl>((ref) {
  final connection = ref.watch(connectionProvider);
  return VendaRepositoryImpl(connection);
});
