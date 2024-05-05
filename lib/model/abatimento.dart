import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class Abatimento extends AbstractModel {
  final int idVenda;
  final double valor;
  final DateTime dateAbatimento;

  Abatimento({
    required this.idVenda,
    required this.valor,
    required this.dateAbatimento,
  });

  @override
  Abatimento copyWith({
    int? idVenda,
    double? valor,
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
      AbatimentoKeys.valor: valor,
      AbatimentoKeys.dateAbatimento: dateAbatimento,
    };
  }

  factory Abatimento.fromJson(Map<String, dynamic> map) {
    return Abatimento(
      idVenda: map[AbatimentoKeys.idVenda],
      valor: map[AbatimentoKeys.valor],
      dateAbatimento:
          Helpers.dbDataToDateTime(map[AbatimentoKeys.dateAbatimento]),
    );
  }
}
