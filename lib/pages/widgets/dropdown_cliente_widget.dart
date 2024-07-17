import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropdownClienteWidget extends ConsumerStatefulWidget {
  final Function(Cliente?) onChanged;
  const DropdownClienteWidget({required this.onChanged, super.key});

  @override
  ConsumerState<DropdownClienteWidget> createState() =>
      _DropdownClienteWidgetState();
}

class _DropdownClienteWidgetState extends ConsumerState<DropdownClienteWidget> {
  Cliente? selectedCliente;
  late ClientesState _clientesState;
  late Size _deviceSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = context.devicesize;
    _clientesState = ref.watch(clientesProvider);
    ref.read(clientesProvider.notifier).getClientes();

    return DropdownButton<Cliente>(
      value: selectedCliente,
      hint: const Text('Selecionar Cliente'),
      items: _clientesState.list.map((Cliente cliente) {
        return DropdownMenuItem<Cliente>(
          value: cliente,
          // child: Text('${cliente.nome} - ${cliente.telefone}'),
          child: _containerCliente(cliente.nome, cliente.telefone),
        );
      }).toList(),
      onChanged: (Cliente? newValue) => {
        setState(() {
          selectedCliente = newValue;
        }),
        widget.onChanged(newValue),
      },
      icon: const Icon(Icons.arrow_downward),
      borderRadius: BorderRadius.circular(32.0),
      dropdownColor: const Color(0xFF006940),
      style: _textStyle(const Color(0xFFEB710A)),
    );
  }

  _textStyle(Color color) {
    return TextStyle(
      fontSize: 14,
      color: color,
    );
  }

  _containerCliente(String nome, String telefone) {
    return Container(
      color: const Color(0xFFEB710A),
      height: _deviceSize.height * 0.1,
      width: _deviceSize.width * 0.7,
      margin: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            nome,
            style: const TextStyle(
              color: Color(0xffFDFFFF),
              fontSize: 14,
            ),
          ),
          Text(
            // telefone,
            formatarTelefone(telefone),
            style: const TextStyle(
              color: Color(0xffFDFFFF),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String formatarTelefone(String telefone) {
    final telefoneFormatado = StringBuffer();

    telefoneFormatado.write('(${telefone.substring(0, 2)}) ');

    if (telefone.length == 11) {
      telefoneFormatado.write('${telefone.substring(2, 7)}-');
      telefoneFormatado.write(telefone.substring(7));
    } else {
      telefoneFormatado.write('${telefone.substring(2, 6)}-');
      telefoneFormatado.write(telefone.substring(6));
    }

    return telefoneFormatado.toString();
  }
}
