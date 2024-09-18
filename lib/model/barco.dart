import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

class Barco extends AbstractModel {
  final int id;
  final String nome;

  Barco({
    required this.id,
    required this.nome,
  });

  Barco.inital({
    this.id = 0,
    this.nome = 'barco',
  });

  @override
  Barco copyWith({
    int? id,
    String? nome,
  }) {
    return Barco(
      id: id ?? this.id,
      nome: nome ?? this.nome,
    );
  }

  @override
  List<Object?> get props {
    return [id, nome];
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      BarcoKeys.idBarco: id,
      BarcoKeys.nome: nome,
    };
  }

  factory Barco.fromJson(Map<String, dynamic> map) {
    return Barco(
      id: map[BarcoKeys.idBarco],
      nome: map[BarcoKeys.nome],
    );
  }
}
