import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/widgets/widgets.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

class ClientesWidget extends ConsumerWidget {
  const ClientesWidget({
    super.key,
    required this.clientes,
    required this.route,
    required this.scrollController,
    required this.onRefresh,
  });

  final List<Cliente> clientes;
  final String route;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
          controller: scrollController,
          itemCount: clientes.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Cliente cliente = clientes[index];
            return GestureDetector(
              child: ClienteWidget(cliente: cliente),
              onTap: () => {
                ref
                    .read(clienteAtualProvider(cliente).notifier)
                    .getVendasPorClienteLazyLoading(),
                context.push(route, extra: cliente),
              },
            );
          },
        ),
      ),
    );
  }
}
