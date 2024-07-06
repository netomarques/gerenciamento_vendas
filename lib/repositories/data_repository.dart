import 'package:vendas_gerenciamento/repositories/repositories.dart';

abstract class DataRepository {
  late DatabaseProvider connection;

  Future<int> insertRecord(Map<String, dynamic> values);

  Future<List<Map<String, dynamic>>> getAllRecords();

  Future<List<Map<String, dynamic>>> getByIdRecord(int id);

  Future<int> updateRecord(Map<String, dynamic> values, int id);

  Future<int> deleteRecord(int id);
}
