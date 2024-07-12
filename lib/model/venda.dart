import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class Venda extends AbstractModel {
  final int? id;
  final double quantidade;
  final double preco;
  final double desconto;
  final DateTime date;
  final Cliente cliente;
  final double? total;
  final bool? fiado;
  final bool? isAberto;
  final double? totalAberto;

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
  });

  @override
  Venda copyWith({
    int? id,
    double? quantidade,
    double? preco,
    double? desconto,
    DateTime? date,
    Cliente? cliente,
    double? total,
    bool? fiado,
    bool? isAberto,
    double? totalAberto,
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
    ];
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      VendaKeys.idVenda: id,
      VendaKeys.quantidade: quantidade,
      VendaKeys.preco: preco,
      VendaKeys.desconto: desconto,
      VendaKeys.dateVenda: date,
      VendaKeys.idCliente: cliente.id,
      VendaKeys.total: total,
    };
  }

  factory Venda.fromJson(Map<String, dynamic> map, Cliente cliente) {
    return Venda(
      id: map[VendaKeys.idVenda],
      quantidade: map[VendaKeys.quantidade],
      preco: map[VendaKeys.preco],
      desconto: map[VendaKeys.desconto],
      date: Helpers.dbDataToDateTime(map[VendaKeys.dateVenda]),
      cliente: cliente,
      total: map[VendaKeys.total],
      fiado: map[VendaKeys.isFiado] == 1 ? true : false,
      isAberto: map[VendaKeys.isAberto] == 1 ? true : false,
      totalAberto: map[VendaKeys.totalEmAberto],
    );
  }
}
