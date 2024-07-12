import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/pages/widgets/widgets.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VendasWidget extends ConsumerWidget {
  const VendasWidget({
    super.key,
    required this.vendas,
    required this.route,
    required this.scrollController,
  });

  final List<Venda> vendas;
  final String route;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: vendas.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Venda venda = vendas[index];
          return GestureDetector(
            child: VendaWidget(venda: venda),
            onTap: () => {
              ref.read(vendaProvider(venda).notifier).getVenda(),
              context.push(route, extra: venda),
            },
          );
        },
      ),
    );
  }
}
