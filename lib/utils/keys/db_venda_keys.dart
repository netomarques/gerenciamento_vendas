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
  static const String idViagemColuna = VendaKeys.idViagem;

  static const String sqlVendas = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    GROUP BY v.$idColuna
    ORDER BY v.$idColuna DESC, v.$dateColuna DESC;
  ''';

  static const String sqlVendasLazyLoading = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$dateColuna BETWEEN ? AND ?
    GROUP BY v.$idColuna
    ORDER BY v.$idColuna DESC, v.$dateColuna DESC
    LIMIT ?
    OFFSET ?;
  ''';

  static const String sqlVenda = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           SUM(CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END) $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$idColuna = ?
    ORDER BY v.$dateColuna DESC;
  ''';

  static const String sqlVendasPorData = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$dateColuna BETWEEN ? AND  ?
    GROUP BY v.$idColuna
    ORDER BY v.$idColuna DESC, v.$dateColuna DESC;
  ''';

  static const String sqlVendasPorCliente = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$idClienteColuna = ?
    ORDER BY v.$idColuna DESC, v.$dateColuna DESC;
  ''';

  static const String sqlTotalEmAbertoDoCliente = '''
    SELECT SUM(CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END) AS sum_total_em_aberto, 
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName v
    WHERE v.$idClienteColuna = ? AND $isAbertoColuna = 1;
  ''';

  static const String sqlVendasPorClienteLazyLoading = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$idClienteColuna = ?
    ORDER BY v.$idColuna DESC, v.$dateColuna DESC
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
    ORDER BY v.$idColuna DESC, v.$dateColuna DESC
    LIMIT ?
    OFFSET ?;
  ''';

  static const String sqlVendasPorBarco = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE  v.$dateColuna BETWEEN ? AND  ? AND v.$idViagemColuna IN (SELECT vg.${DbViagemKeys.idColuna} FROM VIAGEM vg WHERE vg.${DbViagemKeys.idBarcoColuna})
    GROUP BY v.$idColuna
    ORDER BY v.$idColuna DESC, v.$dateColuna DESC;
  ''';

  static const String sqlVendasPorViagem = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE  v.$dateColuna BETWEEN ? AND  ? AND v.$idViagemColuna = ?
    GROUP BY v.$idColuna
    ORDER BY v.$idColuna DESC, v.$dateColuna DESC;
  ''';

  static const String sqlRelatorioVendasPorViagem = '''
    SELECT vg.${DbViagemKeys.pesoColuna} AS peso_total,
           SUM(v.$quantidadeColuna) AS peso_total_vendido,
           COUNT(v.$idColuna) AS numero_de_vendas,
           SUM(v.$totalColuna) AS total_das_vendas,
           (SELECT COUNT(vd.$idColuna) FROM $tableName vd WHERE vd.$idClienteColuna = 1 AND vd.$idViagemColuna = v.$idViagemColuna) AS numero_venda_rua,
           (SELECT SUM(vd.$totalColuna) FROM $tableName vd WHERE vd.$idClienteColuna = 1 AND vd.$idViagemColuna = v.$idViagemColuna) AS total_venda_rua,
           (SELECT COUNT(vd.$idColuna) FROM $tableName vd WHERE vd.$idClienteColuna <> 1 AND vd.$idViagemColuna = v.$idViagemColuna) AS numero_venda_fiado,
           (SELECT SUM(vd.$totalColuna) FROM $tableName vd WHERE vd.$idClienteColuna <> 1 AND vd.$idViagemColuna = v.$idViagemColuna) AS total_venda_fiado,
           (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) 
		       FROM ${DbAbatimentoKeys.tableName} a 
		       WHERE a.${DbAbatimentoKeys.idVendaColuna} in (SELECT vd.$idColuna 
							                                          FROM $tableName vd 
							                                          WHERE vd.$idViagemColuna = v.$idColuna AND vd.$idClienteColuna <> 1)) AS total_pago_venda_fiado,
          ((SELECT SUM(vd.$totalColuna) 
            FROM $tableName vd 
            WHERE vd.$idClienteColuna <> 1 AND vd.$idViagemColuna = v.$idViagemColuna) - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) 
																										                                      FROM ${DbAbatimentoKeys.tableName} a 
																										                                      WHERE a.${DbAbatimentoKeys.idVendaColuna} IN (SELECT vd.$idColuna 
																																                                                                        FROM $tableName vd 
																																                                                                        WHERE vd.$idViagemColuna = v.$idViagemColuna AND vd.$idClienteColuna <> 1))) AS total_a_receber_venda_fiado
    FROM $tableName v
    INNER JOIN ${DbViagemKeys.tableName} vg ON vg.${DbViagemKeys.idColuna} = v.$idViagemColuna
    WHERE v.$idViagemColuna = ?;
  ''';

  static const String sqlRelatorioVendasPorBarco = '''
    SELECT (SELECT SUM(vgm.${DbViagemKeys.pesoColuna}) FROM ${DbViagemKeys.tableName} vgm WHERE vgm.${DbViagemKeys.idBarcoColuna} = vg.${DbViagemKeys.idBarcoColuna}) AS peso_total,
		        SUM(v.$quantidadeColuna) AS peso_total_vendido,
            COUNT(v.$idColuna) AS numero_de_vendas,
            SUM(v.$totalColuna) AS total_das_vendas,
            (SELECT COUNT(vd.$idColuna) FROM $tableName vd WHERE vd.$idClienteColuna = 1 AND vd.$idViagemColuna IN (SELECT vgm.${DbViagemKeys.idColuna} FROM ${DbViagemKeys.tableName} vgm WHERE vgm.${DbViagemKeys.idBarcoColuna} = vg.${DbViagemKeys.idBarcoColuna})) AS numero_venda_rua,
            (SELECT SUM(vd.$totalColuna) FROM $tableName vd WHERE vd.$idClienteColuna = 1 AND vd.$idViagemColuna IN (SELECT vgm.${DbViagemKeys.idColuna} FROM ${DbViagemKeys.tableName} vgm WHERE vgm.${DbViagemKeys.idBarcoColuna} = vg.${DbViagemKeys.idBarcoColuna})) AS total_venda_rua,
            (SELECT COUNT(vd.$idColuna) FROM $tableName vd WHERE vd.$idClienteColuna <> 1 AND vd.$idViagemColuna IN (SELECT vgm.${DbViagemKeys.idColuna} FROM ${DbViagemKeys.tableName} vgm WHERE vgm.${DbViagemKeys.idBarcoColuna} = vg.${DbViagemKeys.idBarcoColuna})) AS numero_venda_fiado,
            (SELECT SUM(vd.$totalColuna) FROM $tableName vd WHERE vd.$idClienteColuna <> 1 AND vd.$idViagemColuna IN (SELECT vgm.${DbViagemKeys.idColuna} FROM ${DbViagemKeys.tableName} vgm WHERE vgm.${DbViagemKeys.idBarcoColuna} = vg.${DbViagemKeys.idBarcoColuna})) AS total_venda_fiado,
            (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) 
		        FROM ${DbAbatimentoKeys.tableName} a 
		        WHERE a.${DbAbatimentoKeys.idVendaColuna} IN (SELECT vd.$idColuna 
                                                          FROM $tableName vd 
                                                          WHERE vd.$idClienteColuna <> 1 AND vd.$idViagemColuna IN (SELECT vgm.${DbViagemKeys.idColuna} 
                                                                                                        FROM ${DbViagemKeys.tableName} vgm 
                                                                                                        WHERE vgm.${DbViagemKeys.idBarcoColuna} = vg.${DbViagemKeys.idBarcoColuna}))) AS total_pago_venda_fiado,
            ((SELECT SUM(vd.$totalColuna) FROM $tableName vd WHERE vd.$idClienteColuna <> 1 AND vd.$idViagemColuna IN (SELECT vgm.${DbViagemKeys.idColuna} FROM ${DbViagemKeys.tableName} vgm WHERE vgm.${DbViagemKeys.idBarcoColuna} = vg.${DbViagemKeys.idBarcoColuna})) - (SELECT sum(a.${DbAbatimentoKeys.valorColuna}) 
                                                                                                                                                                                                                                                                              FROM ${DbAbatimentoKeys.tableName} a 
                                                                                                                                                                                                                                                                              WHERE a.${DbAbatimentoKeys.idVendaColuna} IN (SELECT vd.$idColuna 
                                                                                                                                                                                                                                                                                                                            FROM $tableName vd 
                                                                                                                                                                                                                                                                                                                            WHERE vd.$idClienteColuna <> 1 AND vd.$idViagemColuna IN (SELECT vgm.${DbViagemKeys.idColuna} FROM ${DbViagemKeys.tableName} vgm WHERE vgm.${DbViagemKeys.idBarcoColuna} = vg.${DbViagemKeys.idBarcoColuna})))) AS total_a_receber_venda_fiado
    FROM $tableName v
    INNER JOIN ${DbViagemKeys.tableName} vg ON vg.${DbViagemKeys.idColuna} = v.$idViagemColuna
    WHERE vg.${DbViagemKeys.idBarcoColuna} = ?;
  ''';

  static const String sqlVendasPorViagemLazyLoading = '''
    SELECT v.*, 
           CASE WHEN v.$idClienteColuna == 1 THEN 0 ELSE 1 END $isFiadoColuna,
           CASE WHEN (v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) THEN v.$totalColuna ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $totalEmAbertoColuna,
           CASE WHEN ((v.$idColuna NOT IN (SELECT a.${DbAbatimentoKeys.idVendaColuna} FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) OR ((v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) > 0)) THEN 1 ELSE (v.$totalColuna - (SELECT SUM(a.${DbAbatimentoKeys.valorColuna}) FROM ${DbAbatimentoKeys.tableName} a WHERE a.${DbAbatimentoKeys.idVendaColuna} = v.$idColuna)) END $isAbertoColuna
    FROM $tableName  v
    WHERE v.$idViagemColuna = ? AND v.$dateColuna BETWEEN ? AND  ?
    ORDER BY v.$idColuna DESC, v.$dateColuna DESC
    LIMIT ?
    OFFSET ?;
  ''';
}
