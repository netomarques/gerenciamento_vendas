import 'package:sqflite/sqflite.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

class BarcoRepositoryImpl extends DataRepository {
  @override
  final DatabaseProvider connection;

  BarcoRepositoryImpl(this.connection);

  @override
  Future<int> deleteRecord(int id) async {
    return 0;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllRecords() async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.query(DbBarcoKeys.tableName);
      },
    );
  }

  @override
  Future<int> insertRecord(Map<String, dynamic> values) async {
    return 0;
  }

  @override
  Future<int> updateRecord(Map<String, dynamic> values, int id) async {
    return 0;
  }

  @override
  Future<List<Map<String, dynamic>>> getByIdRecord(int id) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.query(
          DbBarcoKeys.tableName,
          where: '${DbBarcoKeys.idColuna} = $id',
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getBarcoRelatorio(int idBarco) async {
    final Database db = await connection.database;
    final List<dynamic> args = [idBarco];
    return db.transaction(
      (txn) async {
        return txn.rawQuery(DbVendaKeys.sqlRelatorioVendasPorBarco, args);
      },
    );
  }
}
