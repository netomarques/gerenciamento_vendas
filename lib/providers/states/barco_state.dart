import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';

class BarcoState extends Equatable {
  final Barco? barco;
  final List<Viagem> viagens;
  final bool carregando;
  final Decimal? pesoTotal;
  final Decimal? pesoTotalVendido;
  final int? numeroDeVendas;
  final Decimal? totalDasVendas;
  final int? numeroDeVendaRua;
  final Decimal? totalVendaRua;
  final int? numeroDeVendaFiado;
  final Decimal? totalVendaFiado;
  final Decimal? totalRecebidoVendaFiado;
  final Decimal? totalAReceberVendaFiado;
  final List<Venda> vendas;

  const BarcoState(
    this.barco,
    this.viagens,
    this.carregando,
    this.pesoTotal,
    this.pesoTotalVendido,
    this.numeroDeVendas,
    this.totalDasVendas,
    this.numeroDeVendaRua,
    this.totalVendaRua,
    this.numeroDeVendaFiado,
    this.totalVendaFiado,
    this.totalRecebidoVendaFiado,
    this.totalAReceberVendaFiado,
    this.vendas,
  );

  const BarcoState.initial({
    this.barco,
    this.viagens = const [],
    this.carregando = false,
    this.pesoTotal,
    this.pesoTotalVendido,
    this.numeroDeVendas,
    this.totalDasVendas,
    this.numeroDeVendaRua,
    this.totalVendaRua,
    this.numeroDeVendaFiado,
    this.totalVendaFiado,
    this.totalRecebidoVendaFiado,
    this.totalAReceberVendaFiado,
    this.vendas = const [],
  });

  BarcoState copyWith({
    Barco? barco,
    List<Viagem>? viagens,
    bool? carregando,
    Decimal? pesoTotal,
    Decimal? pesoTotalVendido,
    int? numeroDeVendas,
    Decimal? totalDasVendas,
    int? numeroDeVendaRua,
    Decimal? totalVendaRua,
    int? numeroDeVendaFiado,
    Decimal? totalVendaFiado,
    Decimal? totalRecebidoVendaFiado,
    Decimal? totalAReceberVendaFiado,
    List<Venda>? vendas,
  }) {
    return BarcoState(
      barco ?? this.barco,
      viagens ?? this.viagens,
      carregando ?? this.carregando,
      pesoTotal ?? this.pesoTotal,
      pesoTotalVendido ?? this.pesoTotalVendido,
      numeroDeVendas ?? this.numeroDeVendas,
      totalDasVendas ?? this.totalDasVendas,
      numeroDeVendaRua ?? this.numeroDeVendaRua,
      totalVendaRua ?? this.totalVendaRua,
      numeroDeVendaFiado ?? this.numeroDeVendaFiado,
      totalVendaFiado ?? this.totalVendaFiado,
      totalRecebidoVendaFiado ?? this.totalRecebidoVendaFiado,
      totalAReceberVendaFiado ?? this.totalAReceberVendaFiado,
      vendas ?? this.vendas,
    );
  }

  @override
  List<Object?> get props => [
        barco,
        viagens,
        carregando,
        pesoTotal,
        pesoTotalVendido,
        numeroDeVendas,
        totalDasVendas,
        numeroDeVendaRua,
        totalVendaRua,
        numeroDeVendaFiado,
        totalVendaFiado,
        totalRecebidoVendaFiado,
        totalAReceberVendaFiado,
        vendas,
      ];
}
