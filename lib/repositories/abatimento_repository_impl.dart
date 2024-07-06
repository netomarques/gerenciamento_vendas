import 'package:vendas_gerenciamento/repositories/repositories.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';
import 'package:sqflite/sqflite.dart';

class AbatimentoRepositoryImpl extends AbatimentoRepository {
  @override
  final DatabaseProvider connection;

  AbatimentoRepositoryImpl(this.connection);

  @override
  Future<int> deleteRecord(int id) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.delete(
          DbAbatimentoKeys.tableName,
          where: '${DbAbatimentoKeys.idAbatimentoColuna} = ?',
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
        return txn.query(DbAbatimentoKeys.tableName);
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getByIdRecord(int id) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.query(
          DbAbatimentoKeys.tableName,
          where: '${DbAbatimentoKeys.idAbatimentoColuna} = ?',
          whereArgs: [id],
        );
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

  @override
  Future<int> insertRecord(Map<String, dynamic> values) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.insert(
          DbAbatimentoKeys.tableName,
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
        return txn.insert(
          DbAbatimentoKeys.tableName,
          values,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      },
    );
  }
}
