class Cliente {
  int id;
  String nome;
  String telefone;
  String cpf;

  Cliente(
      {required this.id,
      required this.nome,
      required this.telefone,
      this.cpf = "00000000000"});
}
