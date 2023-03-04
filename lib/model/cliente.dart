class Cliente {
  final int id;
  final String nome;
  final String telefone;
  final String cpf;

  Cliente(
      {required this.id,
      required this.nome,
      required this.telefone,
      this.cpf = "00000000000"});
}
