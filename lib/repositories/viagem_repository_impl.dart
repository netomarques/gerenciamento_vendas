import 'package:sqflite/sqflite.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

class ViagemRepositoryImpl extends DataRepository {
  @override
  final DatabaseProvider connection;

  ViagemRepositoryImpl(this.connection);

  @override
  Future<int> deleteRecord(int id) async {
    return 0;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllRecords() async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.query(DbViagemKeys.tableName);
      },
    );
  }

  @override
  Future<int> insertRecord(Map<String, dynamic> values) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.insert(
          DbViagemKeys.tableName,
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
    return db.transaction(
      (txn) async {
        return txn.query(
          DbViagemKeys.tableName,
          where: '${DbViagemKeys.idColuna} = ?',
          whereArgs: [id],
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getViagensPorBarco(int idBarco) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.query(DbViagemKeys.tableName,
            where: '${DbViagemKeys.idBarcoColuna} = ?', whereArgs: [idBarco]);
      },
    );
  }

  Future<List<Map<String, dynamic>>> getViagemRelatorio(int idViagem) async {
    final Database db = await connection.database;
    final List<dynamic> args = [idViagem];
    return db.transaction(
      (txn) async {
        return txn.rawQuery(DbVendaKeys.sqlRelatorioVendasPorViagem, args);
      },
    );
  }
}
