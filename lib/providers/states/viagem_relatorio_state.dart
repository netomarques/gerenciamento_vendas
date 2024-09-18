import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';

class ViagemRelatorioState extends Equatable {
  final Viagem? viagem;
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

  const ViagemRelatorioState(
    this.viagem,
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

  const ViagemRelatorioState.initial({
    this.viagem,
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

  ViagemRelatorioState copyWith({
    Viagem? viagem,
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
    return ViagemRelatorioState(
      viagem ?? this.viagem,
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
        viagem,
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
