import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

class DatabaseProvider {
  static final DatabaseProvider _conexao = DatabaseProvider._();
  factory DatabaseProvider() => _conexao;

  static Database? _database;

  DatabaseProvider._();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // final String dbPath = await getDatabasesPath();
    // final String path = join(dbPath, "vendaspanai.db");
    // // var exists = await databaseExists(path);
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentsDirectory.path, 'vendaspanai.db');

    // exportDatabase();
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> exportDatabase() async {
    try {
      // Obtenha o diretório do banco de dados
      // final directory = await getApplicationDocumentsDirectory();
      final appDocumentsDirectory = await getApplicationDocumentsDirectory();
      // final directory = Directory(
      //     '/data/user/0/br.com.wilsonnetodev.vendas_gerenciamento/databases');
      final dbPath = join(appDocumentsDirectory.path, 'vendaspanai.db');
      final dbFile = File(dbPath);
      if (!await dbFile.exists()) {
        print('Banco de dados original não encontrado: $dbPath');
        return;
      }

      // Obtenha o diretório de destino (armazenamento externo, por exemplo)
      final externalDirectory = await getExternalStorageDirectory();
      if (externalDirectory != null) {
        final newDbDirectory = externalDirectory.path;
        final newDbDir = Directory(newDbDirectory);
        if (!await newDbDir.exists()) {
          await newDbDir.create(recursive: true);
        }
        final newDbPath =
            join(externalDirectory.path, 'vendaspanai_exportado.db');

        // Copie o arquivo de banco de dados
        final newDbFile = File(newDbPath);
        await dbFile.copy(newDbFile.path);

        print('Banco de dados exportado com sucesso para $newDbPath');
      }
    } catch (e) {
      print('Erro ao exportar o banco de dados: $e');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_clientes);
    await db.execute(_vendas);
    await db.execute(_abatimentos);
    await db.insert(DbClienteKeys.tableName, {
      DbClienteKeys.nomeColuna: 'RUA',
      DbClienteKeys.telefoneColuna: '92999999999',
      DbClienteKeys.cpfcnpjColuna: '99999999999'
    });
    // await db.insert(DbClienteKeys.tableName, {
    //   DbClienteKeys.nomeColuna: 'Jose Costa Larga',
    //   DbClienteKeys.telefoneColuna: '92991235963',
    //   DbClienteKeys.cpfcnpjColuna: '12365478965'
    // });
    // await db.insert(DbClienteKeys.tableName, {
    //   DbClienteKeys.nomeColuna: 'Paula Tejano',
    //   DbClienteKeys.telefoneColuna: '92991235333',
    //   DbClienteKeys.cpfcnpjColuna: '32165498785'
    // });
    // await db.insert(DbClienteKeys.tableName, {
    //   DbClienteKeys.nomeColuna: 'Cuca Beludo',
    //   DbClienteKeys.telefoneColuna: '92991235222',
    //   DbClienteKeys.cpfcnpjColuna: '35715968474'
    // });
    // await db.insert(DbClienteKeys.tableName, {
    //   DbClienteKeys.nomeColuna: 'Dayde Costa',
    //   DbClienteKeys.telefoneColuna: '92991235963',
    //   DbClienteKeys.cpfcnpjColuna: '45698732165'
    // });
    // await db.insert(DbClienteKeys.tableName, {
    //   DbClienteKeys.nomeColuna: 'Melbi Lau',
    //   DbClienteKeys.telefoneColuna: '92991235698',
    //   DbClienteKeys.cpfcnpjColuna: '33698521478556'
    // });

    // //------------- INSERINDO VENDAS ------------//
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-01-01',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 299.00,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 3588.00,
    //   DbClienteKeys.idColuna: 2
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-01-27',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 13.50,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 162.00,
    //   DbClienteKeys.idColuna: 5
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-01-28',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 81.00,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 972.00,
    //   DbClienteKeys.idColuna: 1
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-01-31',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 8.70,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 104.40,
    //   DbClienteKeys.idColuna: 6
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-01-31',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 4.50,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 54.00,
    //   DbClienteKeys.idColuna: 1
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-02-05',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 80.00,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 960.00,
    //   DbClienteKeys.idColuna: 2
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-02-07',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 85.00,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 1020.00,
    //   DbClienteKeys.idColuna: 5
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-02-10',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 4.70,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 56.40,
    //   DbClienteKeys.idColuna: 5
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-02-14',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 150.00,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 1800.00,
    //   DbClienteKeys.idColuna: 4
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-02-15',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 67.00,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 804.00,
    //   DbClienteKeys.idColuna: 6
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-02-15',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 58.00,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 696.00,
    //   DbClienteKeys.idColuna: 1
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-02-19',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 26.00,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 312.00,
    //   DbClienteKeys.idColuna: 6
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-02-19',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 4.50,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 54.00,
    //   DbClienteKeys.idColuna: 4
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-02-22',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 48.00,
    //   DbVendaKeys.descontoColuna: 0.0,
    //   DbVendaKeys.totalColuna: 576.00,
    //   DbClienteKeys.idColuna: 1
    // });
    // await db.insert(DbVendaKeys.tableName, {
    //   DbVendaKeys.dateColuna: '2023-02-28',
    //   DbVendaKeys.precoColuna: 12.00,
    //   DbVendaKeys.quantidadeColuna: 24.60,
    //   DbVendaKeys.descontoColuna: 0.20,
    //   DbVendaKeys.totalColuna: 295.00,
    //   DbClienteKeys.idColuna: 1
    // });

    // //------------- INSERINDO ABATIMENTOS ------------//
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-01-01',
    //   DbAbatimentoKeys.valorColuna: 1200.00,
    //   DbVendaKeys.idColuna: 1
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-01-08',
    //   DbAbatimentoKeys.valorColuna: 800.00,
    //   DbVendaKeys.idColuna: 1
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-01-01',
    //   DbAbatimentoKeys.valorColuna: 1200.00,
    //   DbVendaKeys.idColuna: 1
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-01-28',
    //   DbAbatimentoKeys.valorColuna: 972.00,
    //   DbVendaKeys.idColuna: 3
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-01-31',
    //   DbAbatimentoKeys.valorColuna: 54.00,
    //   DbVendaKeys.idColuna: 5
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-15',
    //   DbAbatimentoKeys.valorColuna: 480.00,
    //   DbVendaKeys.idColuna: 6
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-18',
    //   DbAbatimentoKeys.valorColuna: 480.00,
    //   DbVendaKeys.idColuna: 6
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-13',
    //   DbAbatimentoKeys.valorColuna: 350.00,
    //   DbVendaKeys.idColuna: 7
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-21',
    //   DbAbatimentoKeys.valorColuna: 240.00,
    //   DbVendaKeys.idColuna: 7
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-12',
    //   DbAbatimentoKeys.valorColuna: 18.80,
    //   DbVendaKeys.idColuna: 8
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-14',
    //   DbAbatimentoKeys.valorColuna: 18.80,
    //   DbVendaKeys.idColuna: 8
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-22',
    //   DbAbatimentoKeys.valorColuna: 900.00,
    //   DbVendaKeys.idColuna: 9
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-25',
    //   DbAbatimentoKeys.valorColuna: 400.00,
    //   DbVendaKeys.idColuna: 10
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-25',
    //   DbAbatimentoKeys.valorColuna: 696.00,
    //   DbVendaKeys.idColuna: 11
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-28',
    //   DbAbatimentoKeys.valorColuna: 100.00,
    //   DbVendaKeys.idColuna: 12
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-03-05',
    //   DbAbatimentoKeys.valorColuna: 54.00,
    //   DbVendaKeys.idColuna: 13
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-02-22',
    //   DbAbatimentoKeys.valorColuna: 576.00,
    //   DbVendaKeys.idColuna: 14
    // });
    // await db.insert(DbAbatimentoKeys.tableName, {
    //   DbAbatimentoKeys.dateAbatimentoColuna: '2023-01-01',
    //   DbAbatimentoKeys.valorColuna: 295.00,
    //   DbVendaKeys.idColuna: 15
    // });
  }

  String get _clientes => '''
    CREATE TABLE ${DbClienteKeys.tableName} (
      ${DbClienteKeys.idColuna} INTEGER PRIMARY KEY AUTOINCREMENT, 
      ${DbClienteKeys.nomeColuna} TEXT, 
      ${DbClienteKeys.telefoneColuna} TEXT, 
      ${DbClienteKeys.cpfcnpjColuna} TEXT
    );
  ''';

  String get _vendas => '''
    CREATE TABLE ${DbVendaKeys.tableName} (
      ${DbVendaKeys.idColuna} INTEGER PRIMARY KEY AUTOINCREMENT, 
      ${DbVendaKeys.dateColuna} DATE, 
      ${DbVendaKeys.precoColuna} REAL, 
      ${DbVendaKeys.quantidadeColuna} REAL, 
      ${DbVendaKeys.descontoColuna} REAL, 
      ${DbVendaKeys.totalColuna} REAL, 
      ${DbVendaKeys.idClienteColuna} INTEGER, 
      FOREIGN KEY (${DbVendaKeys.idClienteColuna}) REFERENCES Clientes (${DbClienteKeys.idColuna})
    );
  ''';

  String get _abatimentos => '''
    CREATE TABLE ${DbAbatimentoKeys.tableName} (
      ${DbAbatimentoKeys.idAbatimentoColuna} INTEGER PRIMARY KEY AUTOINCREMENT, 
      ${DbAbatimentoKeys.dateAbatimentoColuna} DATE, 
      ${DbAbatimentoKeys.valorColuna} REAL, 
      ${DbAbatimentoKeys.idVendaColuna} INTEGER, 
      FOREIGN KEY (${DbAbatimentoKeys.idVendaColuna}) REFERENCES ${DbVendaKeys.tableName} (${DbVendaKeys.idColuna})
    );
  ''';
}
