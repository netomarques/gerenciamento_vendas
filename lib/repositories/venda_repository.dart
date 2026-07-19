import 'package:vendas_gerenciamento/repositories/data_repository.dart';

abstract class VendaRepository extends DataRepository {
  VendaRepository(super.connection);

  Future<List<Map<String, dynamic>>> getVendasLazyLoading(
    int limit,
    int offset,
    String startDate,
    String endDate,
  );

  Future<List<Map<String, dynamic>>> getAbatimentosPorVenda(int idVenda);

  Future<List<Map<String, dynamic>>> getVendasPorData(
    String startDate,
    String endDate,
  );

  Future<List<Map<String, dynamic>>> getVendasPorClientes(int idCliente);

  Future<List<Map<String, dynamic>>> getTotalEmAbertoDoCliente(int idCliente);

  Future<List<Map<String, dynamic>>> getVendasPorClientesLazyLoading(
    int idCliente,
    int limit,
    int offset,
    String startDate,
    String endDate,
  );

  Future<List<Map<String, dynamic>>> getVendasPorViagemLazyLoading(
    int idViagem,
    int limit,
    int offset,
    String startDate,
    String endDate,
  );
}
