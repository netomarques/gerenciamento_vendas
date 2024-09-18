import 'package:decimal/decimal.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class Viagem extends AbstractModel {
  final int id;
  final Barco barco;
  final Decimal peso;
  final DateTime dateChegada;
  final DateTime? dateFechada;

  Viagem({
    required this.id,
    required this.barco,
    required this.peso,
    required this.dateChegada,
    this.dateFechada,
  });

  Viagem.initial({
    this.id = 0,
    required this.barco,
    required this.peso,
    required this.dateChegada,
    required this.dateFechada,
  });

  @override
  Viagem copyWith({
    int? id,
    Barco? barco,
    Decimal? peso,
    DateTime? dateChegada,
    DateTime? dateFechada,
  }) {
    return Viagem(
      id: id ?? this.id,
      barco: barco ?? this.barco,
      peso: peso ?? this.peso,
      dateChegada: dateChegada ?? this.dateChegada,
      dateFechada: dateFechada ?? this.dateFechada,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      barco,
      peso,
      dateChegada,
      dateFechada,
    ];
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ViagemKeys.idViagem: id,
      ViagemKeys.idBarco: barco.id,
      ViagemKeys.peso: peso.toDouble(),
      ViagemKeys.dateViagemChegada:
          Helpers.formatarDateTimeToDateDB(dateChegada),
    };
  }

  factory Viagem.fromJson(Map<String, dynamic> map) {
    return Viagem(
      id: map[ViagemKeys.idViagem],
      barco: map['barco'],
      peso: Decimal.parse(map[ViagemKeys.peso].toString()),
      dateChegada: Helpers.dbDataToDateTime(map[ViagemKeys.dateViagemChegada]),
      dateFechada: map[ViagemKeys.dateViagemFechada] != null
          ? Helpers.dbDataToDateTime(map[ViagemKeys.dateViagemFechada])
          : null,
    );
  }
}
