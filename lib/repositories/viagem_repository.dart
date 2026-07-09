import 'package:vendas_gerenciamento/repositories/data_repository.dart';

abstract class ViagemRepository extends DataRepository {
  ViagemRepository(super.connection);

  Future<List<Map<String, dynamic>>> getViagensPorBarco(int idBarco);

  Future<List<Map<String, dynamic>>> getViagemRelatorio(int idViagem);
}
