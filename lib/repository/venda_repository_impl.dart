import 'package:sqflite/sqflite.dart';
import 'package:vendas_gerenciamento/repository/repository.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

class VendaRepositoryImpl extends DataRepository {
  @override
  final DatabaseProvider connection;

  VendaRepositoryImpl(this.connection);

  @override
  Future<int> deleteRecord(int id) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.delete(
          DbVendaKeys.tableName,
          where: '${DbVendaKeys.idColuna} = ?',
          whereArgs: [id],
        );
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAllRecords() async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.rawQuery(DbVendaKeys.sqlVendas);
      },
    );
  }

  @override
  Future<int> insertRecord(Map<String, dynamic> values) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.insert(
          DbVendaKeys.tableName,
          values,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      },
    );
  }

  @override
  Future<int> updateRecord(Map<String, dynamic> values, int id) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.update(
          DbVendaKeys.tableName,
          values,
          where: '${DbVendaKeys.idColuna} = ?',
          whereArgs: [id],
        );
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getByIdRecord(int id) async {
    final Database db = await connection.database;
    final List<dynamic> args = [id];
    return db.transaction(
      (txn) async {
        return txn.rawQuery(DbVendaKeys.sqlVendas, args);
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAbatimentosPorVenda(int idVenda) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.query(
          DbAbatimentoKeys.tableName,
          where: '${DbAbatimentoKeys.idVendaColuna} = ?',
          whereArgs: [idVenda],
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getVendasPorData(
      String startDate, String endDate) async {
    final Database db = await connection.database;
    final List<dynamic> args = [startDate, endDate];
    return db.transaction(
      (txn) async {
        return txn.rawQuery(DbVendaKeys.sqlVendasPorData, args);
      },
    );
  }
}
