import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/pages/widgets/venda_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendasWidget extends ConsumerWidget {
  const VendasWidget({
    super.key,
    required this.vendas,
    required this.route,
  });

  final List<Venda> vendas;
  final String route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        itemCount: vendas.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Venda venda = vendas[index];
          return GestureDetector(
            onTap: () => context.push(route, extra: venda),
            child: VendaWidget(venda: venda),
          );
        },
      ),
    );
  }
}
