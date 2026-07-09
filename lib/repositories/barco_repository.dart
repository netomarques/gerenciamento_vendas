import 'package:vendas_gerenciamento/repositories/data_repository.dart';

abstract class BarcoRepository extends DataRepository {
  BarcoRepository(super.connection);

  Future<List<Map<String, dynamic>>> getBarcoRelatorio(int idBarco);
}
