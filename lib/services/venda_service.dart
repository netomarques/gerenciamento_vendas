import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:vendas_gerenciamento/utils/keys/db_venda_keys.dart';

class VendaService {
  final VendaRepositoryImpl _repository;
  final ClienteService _clienteService;
  final AbatimentoService _abatimentoService;
  final ViagemService _viagemService;

  VendaService(
    this._repository,
    this._clienteService,
    this._abatimentoService,
    this._viagemService,
  );

  Future<List<Venda>> getVendas() async {
    try {
      final resultados = await _repository.getAllRecords();
      final List<Venda> vendas = await _mapearResultadosParaVendas(resultados);

      return vendas;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Venda');
    }
  }

  Future<List<Venda>> getVendasLazyLoading(
    int limit,
    int offset,
    String startDate,
    String endDate,
  ) async {
    try {
      final resultados = await _repository.getVendasLazyLoading(
          limit, offset, startDate, endDate);

      final List<Venda> vendas = await _mapearResultadosParaVendas(resultados);

      return vendas;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao buscar Vendas');
    }
  }

  Future<int> _salvarVenda(Venda venda) {
    try {
      final vendaJson = venda.toJson();
      return _repository.insertRecord(vendaJson);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao salvar Venda');
    }
  }

  Future<int> salvarVendaRua(Venda venda, Abatimento abatimento) async {
    try {
      final idVenda = await _salvarVenda(venda);
      abatimento = abatimento.copyWith(idVenda: idVenda);
      await _abatimentoService.salvarAbatimento(abatimento);

      return idVenda;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao salvar Venda Rua');
    }
  }

  Future<int> salvarVendaFiado(Venda venda, Abatimento? abatimento) async {
    try {
      final idVenda = await _salvarVenda(venda);

      if (abatimento != null) {
        abatimento = abatimento.copyWith(idVenda: idVenda);
        await _abatimentoService.salvarAbatimento(abatimento);
      }
      return idVenda;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao salvar Venda Fiado');
    }
  }

  Future<List<Venda>> getVendasPorData(String startDate, String endDate) async {
    try {
      final resultados = await _repository.getVendasPorData(startDate, endDate);

      final List<Venda> vendas = await _mapearResultadosParaVendas(resultados);

      return vendas;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Vendas por Data');
    }
  }

  Future<Venda> getVendaId(int id) async {
    try {
      final resultado = await _repository.getByIdRecord(id);
      if (resultado.isEmpty) {
        throw Exception('Venda não encontrada para o id $id');
      }
      final json = resultado.first;
      final vendaJson = Map<String, dynamic>.from(json);

      await _buscarClienteEViagemDaVenda(vendaJson);

      Venda venda = Venda.fromJson(vendaJson);
      return venda;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Venda');
    }
  }

  Future<Decimal> getTotalEmAbertoDoCliente(int idCliente) async {
    try {
      final resultado = await _repository.getTotalEmAbertoDoCliente(idCliente);
      double resultadoDouble = resultado.first['sum_total_em_aberto'] ?? 0.0;
      Decimal totalEmAberto;
      if (resultadoDouble != 0.0) {
        totalEmAberto = Decimal.parse(
            Decimal.parse(resultadoDouble.toString()).toStringAsFixed(2));
      } else {
        totalEmAberto = Decimal.zero;
      }

      return totalEmAberto;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Total Em Aberto Do Cliente');
    }
  }

  Future<List<Abatimento>> getAbatimentosPorVenda(int idVenda) async {
    try {
      final List<Abatimento> abatimentos = [];
      final resultados = await _repository.getAbatimentosPorVenda(idVenda);
      for (var json in resultados) {
        final abatimento = Abatimento.fromJson(json);
        abatimentos.add(abatimento);
      }
      return abatimentos;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Abatimentos');
    }
  }

  Future<List<Venda>> getVendasPorCliente(int idCliente) async {
    try {
      final resultados = await _repository.getVendasPorClientes(idCliente);
      final List<Venda> vendas = await _mapearResultadosParaVendas(resultados);

      return vendas;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Venda por Cliente');
    }
  }

  Future<List<Venda>> getVendasPorClienteLazyLoading(
    int idCliente,
    int limit,
    int offset,
    String startDate,
    String endDate,
  ) async {
    try {
      final resultados = await _repository.getVendasPorClientesLazyLoading(
        idCliente,
        limit,
        offset,
        startDate,
        endDate,
      );

      final List<Venda> vendas = await _mapearResultadosParaVendas(resultados);

      return vendas;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Venda por Cliente');
    }
  }

  Future<void> _buscarClienteEViagemDaVenda(
      Map<String, dynamic> vendaJson) async {
    final results = await Future.wait<Object?>([
      _clienteService.getClienteId(vendaJson[DbVendaKeys.idClienteColuna]),
      _viagemService.getViagemId(vendaJson[DbVendaKeys.idViagemColuna]),
    ]);
    vendaJson['cliente'] = results[0];
    vendaJson['viagem'] = results[1];
  }

  Future<List<Venda>> getVendasPorViagemLazyLoading(
    int idViagem,
    int limit,
    int offset,
    String startDate,
    String endDate,
  ) async {
    try {
      final resultados = await _repository.getVendasPorViagemLazyLoading(
        idViagem,
        limit,
        offset,
        startDate,
        endDate,
      );

      final List<Venda> vendas = await _mapearResultadosParaVendas(resultados);

      return vendas;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Venda por Viagem');
    }
  }

  Future<List<Venda>> _mapearResultadosParaVendas(
      List<Map<String, Object?>> resultados) async {
    return Future.wait<Venda>(resultados.map((json) async {
      final vendaJson = Map<String, dynamic>.from(json);
      await _buscarClienteEViagemDaVenda(vendaJson);
      return Venda.fromJson(vendaJson);
    }));
  }
}
