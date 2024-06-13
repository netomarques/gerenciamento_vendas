import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/utils/keys/keys.dart';

class Cliente extends AbstractModel {
  final int? id;
  final String nome;
  final String telefone;
  final String cpf;

  Cliente({
    this.id,
    required this.nome,
    required this.telefone,
    this.cpf = "00000000000",
  });

  @override
  Cliente copyWith({
    int? id,
    String? nome,
    String? telefone,
    String? cpf,
  }) {
    return Cliente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      cpf: cpf ?? this.cpf,
    );
  }

  @override
  List<Object?> get props {
    return [
      id!,
      nome,
      telefone,
      cpf,
    ];
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ClienteKeys.idCliente: id,
      ClienteKeys.nome: nome,
      ClienteKeys.telefone: telefone,
      ClienteKeys.cpfcnpj: cpf,
    };
  }

  factory Cliente.fromJson(Map<String, dynamic> map) {
    return Cliente(
      id: map[ClienteKeys.idCliente],
      nome: map[ClienteKeys.nome],
      telefone: map[ClienteKeys.telefone],
      cpf: map[ClienteKeys.cpfcnpj] ?? "00000000000",
    );
  }
}
