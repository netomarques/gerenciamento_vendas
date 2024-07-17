import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/repositories/repositories.dart';
import 'package:vendas_gerenciamento/services/service.dart';
import 'package:vendas_gerenciamento/utils/keys/db_venda_keys.dart';

class VendaService {
  final VendaRepositoryImpl _repository;
  final ClienteService _clienteService;
  final AbatimentoService _abatimentoService;

  VendaService(this._repository, this._clienteService, this._abatimentoService);

  Future<List<Venda>> getVendas() async {
    try {
      final resultados = await _repository.getAllRecords();
      final List<Venda> vendas = [];

      for (var vendaJson in resultados) {
        final Cliente cliente = await _clienteService
            .getClienteId(vendaJson[DbVendaKeys.idClienteColuna]);
        vendas.add(Venda.fromJson(vendaJson, cliente));
      }

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

      final List<Venda> vendas = [];
      for (var vendaJson in resultados) {
        final Cliente cliente = await _clienteService
            .getClienteId(vendaJson[DbVendaKeys.idClienteColuna]);
        vendas.add(Venda.fromJson(vendaJson, cliente));
      }

      return vendas;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Venda');
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
      throw Exception(e);
    }
  }

  Future<int> salvarVendaFiado(Venda venda, Abatimento? abatimento) async {
    try {
      final vendaJson = venda.toJson();
      int idVenda = await _repository.insertRecord(vendaJson);

      if (abatimento != null) {
        abatimento = abatimento.copyWith(idVenda: idVenda);
        await _abatimentoService.salvarAbatimento(abatimento);
      }
      return idVenda;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Venda>> getVendasPorData(String startDate, String endDate) async {
    try {
      final resultados = await _repository.getVendasPorData(startDate, endDate);
      final List<Venda> vendas = [];

      for (var vendaJson in resultados) {
        final Cliente cliente = await _clienteService
            .getClienteId(vendaJson[DbVendaKeys.idClienteColuna]);
        vendas.add(Venda.fromJson(vendaJson, cliente));
      }

      return vendas;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Venda');
    }
  }

  Future<Venda> getVendaId(int id) async {
    try {
      final resultado = await _repository.getByIdRecord(id);
      final Cliente cliente = await _clienteService
          .getClienteId(resultado.first[DbVendaKeys.idClienteColuna]);
      Venda venda = List.generate(resultado.length,
          (index) => Venda.fromJson(resultado[index], cliente)).first;
      return venda;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Venda');
    }
  }

  Future<double> getTotalEmAbertoDoCliente(int idCliente) async {
    try {
      final resultado = await _repository.getTotalEmAbertoDoCliente(idCliente);
      double totalEmAberto = resultado.first['sum_total_em_aberto'] ?? 0.0;
      return totalEmAberto;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Total Em Aberto Do Cliente');
    }
  }

  Future<List<Abatimento>> getAbatimentosPorVenda(idVenda) async {
    try {
      final resultado = await _repository.getAbatimentosPorVenda(idVenda);
      final List<Abatimento> abatimentos = List.generate(
          resultado.length, (index) => Abatimento.fromJson(resultado[index]));
      return abatimentos;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Abatimentos');
    }
  }

  Future<List<Venda>> getVendasPorCliente(idCliente) async {
    try {
      final resultados = await _repository.getVendasPorClientes(idCliente);
      final List<Venda> vendas = [];

      for (var vendaJson in resultados) {
        final Cliente cliente = await _clienteService
            .getClienteId(vendaJson[DbVendaKeys.idClienteColuna]);
        vendas.add(Venda.fromJson(vendaJson, cliente));
      }

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

      final List<Venda> vendas = [];
      for (var vendaJson in resultados) {
        final Cliente cliente = await _clienteService
            .getClienteId(vendaJson[DbVendaKeys.idClienteColuna]);
        vendas.add(Venda.fromJson(vendaJson, cliente));
      }

      return vendas;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Erro ao consultar Venda por Cliente');
    }
  }
}
