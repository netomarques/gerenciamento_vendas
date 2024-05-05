import 'package:vendas_gerenciamento/model/model.dart';

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
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'cpf': cpf,
    };
  }

  factory Cliente.fromJson(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
      cpf: map['cpf'] ?? "00000000000",
    );
  }
}
