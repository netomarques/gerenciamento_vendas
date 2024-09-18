import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/pages/widgets/widgets.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ViagensWidget extends ConsumerWidget {
  const ViagensWidget({
    super.key,
    required this.viagens,
    required this.route,
    required this.scrollController,
  });

  final List<Viagem> viagens;
  final String route;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: viagens.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Viagem viagem = viagens[index];
          return GestureDetector(
            child: ViagemWidget(viagem: viagem),
            onTap: () => {
              ref.read(viagemProvider(viagem).notifier).getViagem(),
              context.push(route, extra: viagem),
            },
          );
        },
      ),
    );
  }
}
