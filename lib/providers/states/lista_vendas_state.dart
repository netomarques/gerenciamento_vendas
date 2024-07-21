import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:decimal/decimal.dart';

class ListaVendasState extends Equatable {
  final List<Venda> list;
  final int limit;
  final bool carregando;
  final bool filtroPorData;
  final Decimal totalDasVendas;
  final int qtdeVendaRua;
  final int qtdeVendaFiado;
  final Decimal totalDaVendaRua;
  final Decimal totalDaVendaFiado;
  final DateTime startDate;
  final DateTime endDate;

  const ListaVendasState(
    this.list,
    this.limit,
    this.carregando,
    this.filtroPorData,
    this.totalDasVendas,
    this.qtdeVendaRua,
    this.qtdeVendaFiado,
    this.totalDaVendaRua,
    this.totalDaVendaFiado,
    this.startDate,
    this.endDate,
  );

  const ListaVendasState.initial({
    this.list = const [],
    this.limit = 10,
    this.carregando = false,
    this.filtroPorData = false,
    required this.totalDasVendas,
    this.qtdeVendaRua = 0,
    this.qtdeVendaFiado = 0,
    required this.totalDaVendaRua,
    required this.totalDaVendaFiado,
    required this.startDate,
    required this.endDate,
  });

  ListaVendasState copyWith({
    List<Venda>? list,
    int? limit,
    bool? carregando,
    bool? filtroPorData,
    Decimal? totalDasVendas,
    int? qtdeVendaRua,
    int? qtdeVendaFiado,
    Decimal? totalDaVendaRua,
    Decimal? totalDaVendaFiado,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ListaVendasState(
      list ?? this.list,
      limit ?? this.limit,
      carregando ?? this.carregando,
      filtroPorData ?? this.filtroPorData,
      totalDasVendas ?? this.totalDasVendas,
      qtdeVendaRua ?? this.qtdeVendaRua,
      qtdeVendaFiado ?? this.qtdeVendaFiado,
      totalDaVendaRua ?? this.totalDaVendaRua,
      totalDaVendaFiado ?? this.totalDaVendaFiado,
      startDate ?? this.startDate,
      endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [
        list,
        limit,
        carregando,
        filtroPorData,
        totalDasVendas,
        qtdeVendaRua,
        qtdeVendaFiado,
        totalDaVendaRua,
        totalDaVendaFiado,
        startDate,
        endDate
      ];
}
