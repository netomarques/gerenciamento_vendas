import 'package:equatable/equatable.dart';
import 'package:vendas_gerenciamento/model/model.dart';

class ListaVendasState extends Equatable {
  final List<Venda> list;
  final int limit;
  final bool carregando;
  final bool filtroPorData;
  final double totalDasVendas;
  final int qtdeVendaRua;
  final int qtdeVendaFiado;
  final double totalDaVendaRua;
  final double totalDaVendaFiado;
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
    this.totalDasVendas = 0.0,
    this.qtdeVendaRua = 0,
    this.qtdeVendaFiado = 0,
    this.totalDaVendaRua = 0.0,
    this.totalDaVendaFiado = 0.0,
    required this.startDate,
    required this.endDate,
  });

  ListaVendasState copyWith({
    List<Venda>? list,
    int? limit,
    bool? carregando,
    bool? filtroPorData,
    double? totalDasVendas,
    int? qtdeVendaRua,
    int? qtdeVendaFiado,
    double? totalDaVendaRua,
    double? totalDaVendaFiado,
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
