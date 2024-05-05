import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/repository/repository.dart';

final clienteRepositoryProvider = Provider<DataRepository>((ref) {
  final connection = ref.watch(connectionProvider);
  return ClienteRepositoryImpl(connection);
});
