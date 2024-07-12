import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

@immutable
class DbVendaKeys {
  const DbVendaKeys._();

  static const String tableName = 'Vendas';
  static const String idColuna = VendaKeys.idVenda;
  static const String dateColuna = VendaKeys.dateVenda;
  static const String precoColuna = VendaKeys.preco;
  static const String quantidadeColuna = VendaKeys.quantidade;
  static const String descontoColuna = VendaKeys.desconto;
  static const String totalColuna = VendaKeys.total;
  static const String isFiadoColuna = VendaKeys.isFiado;
  static const String isAbertoColuna = VendaKeys.isAberto;
  static const String totalEmAbertoColuna = VendaKeys.totalEmAberto;
  static const String idClienteColuna = VendaKeys.idCliente;

  static const String sqlVendas = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    GROUP BY v.$idColuna
    ORDER BY v.$dateColuna DESC;
  ''';

  static const String sqlVendasLazyLoading = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$dateColuna BETWEEN ? AND ?
    GROUP BY v.$idColuna
    ORDER BY v.$dateColuna DESC
    LIMIT ?
    OFFSET ?;
  ''';

  static const String sqlVenda = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           SUM(CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END) $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$idColuna = ?;
  ''';

  static const String sqlVendasPorData = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$dateColuna BETWEEN ? AND  ?
    GROUP BY v.$idColuna
    ORDER BY v.$dateColuna DESC;
  ''';

  static const String sqlVendasPorCliente = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$idClienteColuna = ?
    ORDER BY v.$dateColuna DESC;
  ''';

  static const String sqlTotalEmAbertoDoCliente = '''
    SELECT SUM(CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END) AS sum_total_em_aberto, 
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName v
    WHERE v.$idClienteColuna = ? AND $isAbertoColuna = 1
    ORDER BY v.$dateColuna DESC;
  ''';

  static const String sqlVendasPorClienteLazyLoading = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$idClienteColuna = ?
    ORDER BY v.$dateColuna DESC
    LIMIT ?
    OFFSET ?;
  ''';

  static const String sqlVendasPorClienteLazyLoadingPorData = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$idClienteColuna = ? AND v.$dateColuna BETWEEN ? AND  ?
    ORDER BY v.$dateColuna DESC
    LIMIT ?
    OFFSET ?;
  ''';
}
