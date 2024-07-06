import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';

final connectionProvider = Provider<DatabaseProvider>((ref) {
  return DatabaseProvider();
});
