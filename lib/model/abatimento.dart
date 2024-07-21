import 'package:decimal/decimal.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class Abatimento extends AbstractModel {
  final int idVenda;
  final Decimal valor;
  final DateTime dateAbatimento;

  Abatimento({
    required this.idVenda,
    required this.valor,
    required this.dateAbatimento,
  });

  @override
  Abatimento copyWith({
    int? idVenda,
    Decimal? valor,
    DateTime? dateAbatimento,
  }) {
    return Abatimento(
      idVenda: idVenda ?? this.idVenda,
      valor: valor ?? this.valor,
      dateAbatimento: dateAbatimento ?? this.dateAbatimento,
    );
  }

  @override
  List<Object?> get props {
    return [
      idVenda,
      valor,
      dateAbatimento,
    ];
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      AbatimentoKeys.idVenda: idVenda,
      AbatimentoKeys.valor: valor.toDouble(),
      AbatimentoKeys.dateAbatimento:
          Helpers.formatarDateTimeToDateDB(dateAbatimento),
    };
  }

  factory Abatimento.fromJson(Map<String, dynamic> map) {
    return Abatimento(
      idVenda: map[AbatimentoKeys.idVenda],
      valor: Decimal.parse(map[AbatimentoKeys.valor].toString()),
      dateAbatimento:
          Helpers.dbDataToDateTime(map[AbatimentoKeys.dateAbatimento]),
    );
  }
}
