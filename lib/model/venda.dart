import 'package:decimal/decimal.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class Venda extends AbstractModel {
  final int? id;
  final Decimal quantidade;
  final Decimal preco;
  final Decimal desconto;
  final DateTime date;
  final Cliente cliente;
  final Decimal? total;
  final bool? fiado;
  final bool? isAberto;
  final Decimal? totalAberto;
  final Viagem viagem;

  Venda({
    this.id,
    required this.quantidade,
    required this.preco,
    required this.date,
    required this.cliente,
    required this.desconto,
    this.total,
    this.fiado,
    this.isAberto,
    this.totalAberto,
    required this.viagem,
  });

  Venda.initial({
    this.id,
    required this.quantidade,
    required this.preco,
    required this.desconto,
    required this.date,
    required this.cliente,
    required this.total,
    this.fiado,
    this.isAberto,
    this.totalAberto,
    required this.viagem,
  });

  @override
  Venda copyWith({
    int? id,
    Decimal? quantidade,
    Decimal? preco,
    Decimal? desconto,
    DateTime? date,
    Cliente? cliente,
    Decimal? total,
    bool? fiado,
    bool? isAberto,
    Decimal? totalAberto,
    Viagem? viagem,
  }) {
    return Venda(
      id: id ?? this.id,
      quantidade: quantidade ?? this.quantidade,
      preco: preco ?? this.preco,
      desconto: desconto ?? this.desconto,
      date: date ?? this.date,
      cliente: cliente ?? this.cliente,
      total: total ?? this.total,
      fiado: fiado ?? this.fiado,
      isAberto: isAberto ?? this.isAberto,
      totalAberto: totalAberto ?? this.totalAberto,
      viagem: viagem ?? this.viagem,
    );
  }

  @override
  List<Object?> get props {
    return [
      id!,
      quantidade,
      preco,
      desconto,
      date,
      cliente,
      total!,
      viagem,
    ];
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      VendaKeys.idVenda: id,
      VendaKeys.quantidade: quantidade.toDouble(),
      VendaKeys.preco: preco.toDouble(),
      VendaKeys.desconto: desconto.toDouble(),
      VendaKeys.dateVenda: Helpers.formatarDateTimeToDateDB(date),
      VendaKeys.idCliente: cliente.id,
      VendaKeys.total: total!.toDouble(),
      VendaKeys.idViagem: viagem.id,
    };
  }

  factory Venda.fromJson(Map<String, dynamic> map) {
    return Venda(
      id: map[VendaKeys.idVenda],
      quantidade: Decimal.parse(map[VendaKeys.quantidade].toString()),
      preco: Decimal.parse(map[VendaKeys.preco].toString()),
      desconto: Decimal.parse(map[VendaKeys.desconto].toString()),
      date: Helpers.dbDataToDateTime(map[VendaKeys.dateVenda]),
      cliente: map['cliente'],
      total: Decimal.parse(map[VendaKeys.total].toString()),
      fiado: map[VendaKeys.isFiado] == 1 ? true : false,
      isAberto: map[VendaKeys.isAberto] == 1 ? true : false,
      totalAberto: Decimal.parse(
          Decimal.parse(map[VendaKeys.totalEmAberto].toString())
              .toStringAsFixed(2)),
      viagem: map['viagem'],
    );
  }

  // @override
  // String toString() {
  //   return 'Venda{id: $id, quantidade: $quantidade '
  //       'preco: $preco, desconto: $desconto, '
  //       'date: $date, cliente: $cliente, '
  //       'total: $total, fiado: $fiado, '
  //       'isAberto: $isAberto, totalAberto: $totalAberto}';
  // }
}
