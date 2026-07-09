import 'package:vendas_gerenciamento/repositories/repositories.dart';

abstract class ClienteRepository extends DataRepository {
  ClienteRepository(super.connection);

  Future<List<Map<String, dynamic>>> getClientesLazyLoading(
    int limit,
    int offset,
  );

  Future<List<Map<String, dynamic>>> getClientesPorNome(
    String nome,
    int limit,
    int offset,
  );
}
