import 'package:flutter_riverpod/legacy.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final viagemProvider = StateNotifierProvider.autoDispose
    .family<ViagemNotifier, ViagemRelatorioState, Viagem>((ref, viagem) {
  final viagemService = ref.read(viagemServiceProvider);
  final vendaService = ref.read(vendaServiceProvider);
  return ViagemNotifier(viagemService, vendaService, viagem);
});
