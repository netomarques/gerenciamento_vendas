import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:vendas_gerenciamento/utils/utils.dart';

class ClienteWidget extends ConsumerWidget {
  final Cliente cliente;

  const ClienteWidget({
    super.key,
    required this.cliente,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clienteState = ref.watch(clienteAtualProvider(cliente));
    Size deviceSize = context.devicesize;

    return Container(
      color: const Color(0xFFEB710A),
      height: deviceSize.height * 0.1,
      margin: const EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                clienteState.cliente!.nome,
                style: const TextStyle(
                  color: Color(0xFFFDFFFF),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            height: deviceSize.height * 0.1,
            width: deviceSize.height * 0.15,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              formatarTelefone(clienteState.cliente!.telefone),
              style: const TextStyle(
                color: Color(0xFFFDFFFF),
                fontSize: 16,
              ),
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
