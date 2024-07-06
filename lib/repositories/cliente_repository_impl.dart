import 'package:sqflite/sqflite.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

class ClienteRepositoryImpl extends ClienteRepository {
  @override
  final DatabaseProvider connection;

  ClienteRepositoryImpl(this.connection);

  @override
  Future<int> deleteRecord(int id) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.delete(
          DbClienteKeys.tableName,
          where: '${DbClienteKeys.idColuna} = ?',
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
        return txn.query(DbClienteKeys.tableName);
      },
    );
  }

  Future<List<Map<String, dynamic>>> getClientesLazyLoading(
      int limit, int offset) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.query(
          DbClienteKeys.tableName,
          limit: limit,
          offset: offset,
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
          DbClienteKeys.tableName,
          where: '${DbClienteKeys.idColuna} = ?',
          whereArgs: [id],
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
          DbClienteKeys.tableName,
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
          DbClienteKeys.tableName,
          values,
          where: '${DbClienteKeys.idColuna} = ?',
          whereArgs: [id],
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getClientesPorNome(String nome, int limit, int offset) async {
    final Database db = await connection.database;
    return db.transaction(
      (txn) async {
        return txn.query(
          DbClienteKeys.tableName,
          where: '${DbClienteKeys.nomeColuna} LIKE ?',
          whereArgs: ['$nome%'],
          limit: limit,
          offset: offset,
        );
      },
    );
  }
}
