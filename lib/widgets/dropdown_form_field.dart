import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/cliente.dart';

class DropdownFormField extends StatelessWidget {
  final Cliente value;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final List<Cliente> clientes;

  const DropdownFormField(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.validator,
      required this.clientes});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Cliente>> items = buildDropDownMenuItems(clientes);

    return DropdownButtonFormField<Cliente>(
      decoration: _dropdownInputDecoration('Cliente'),
      value: value,
      items: items,
      onChanged: (value) => onChanged,
      validator: null,
    );
  }

  List<DropdownMenuItem<Cliente>> buildDropDownMenuItems(
      List<Cliente> clientes) {
    List<DropdownMenuItem<Cliente>> items = [];
    for (Cliente cliente in clientes) {
      items.add(
        DropdownMenuItem(
          value: cliente,
          child: Text(
            '${cliente.nome} - ${cliente.telefone}',
          ),
        ),
      );
    }
    return items;
  }

  InputDecoration _dropdownInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF910029),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      filled: true,
      fillColor: const Color(0xFFFDFFFF).withOpacity(0.75),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
        borderSide: const BorderSide(
          color: Color(0xFF006940),
          width: 1.0,
        ),
      ),
    );
  }
}
