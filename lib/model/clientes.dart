import 'package:vendas_gerenciamento/model/cliente.dart';

final Map<String, Cliente> clientes = {
  '1': Cliente(
    id: 1,
    nome: "RUA",
    telefone: "00000000000",
  ),
  '2': Cliente(
    id: 2,
    nome: "Jose Costa Larga",
    telefone: "92991235963",
    cpf: "12345678900",
  ),
  '3': Cliente(
    id: 3,
    nome: "Paula Tejano",
    telefone: "92991235333",
    cpf: "12345678900",
  ),
  '4': Cliente(
    id: 4,
    nome: "Cuca Beludo",
    telefone: "92991235222",
  ),
  '5': Cliente(
    id: 5,
    nome: "Dayde Costa",
    telefone: "92991235963",
    cpf: "12345678900",
  ),
  '6': Cliente(
    id: 6,
    nome: "Melbi Lau",
    telefone: "92991235963",
    cpf: "12345678900",
  ),
};

Cliente getCliente(int id) {
  Cliente cliente;
  cliente = clientes.values.where((cli) => cli.id == id) as Cliente;

  return cliente;
}