import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/venda.dart';
import 'package:vendas_gerenciamento/pages/widgets/venda_widget.dart';
import 'package:go_router/go_router.dart';

class VendasWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: vendas.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Venda venda = vendas[index];
          return GestureDetector(
            onTap: () => context.push(route, extra: venda.id),
            child: VendaWidget(venda: venda),
          );
        },
      ),
    );
  }
}
