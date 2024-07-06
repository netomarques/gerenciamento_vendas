import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';

final clienteRepositoryProvider = Provider<ClienteRepositoryImpl>((ref) {
  final connection = ref.read(connectionProvider);
  return ClienteRepositoryImpl(connection);
});
