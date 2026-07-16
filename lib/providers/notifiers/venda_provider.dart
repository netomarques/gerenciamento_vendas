import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final vendaProvider =
    NotifierProvider.family.autoDispose<VendaNotifier, VendaState, Venda>(
  VendaNotifier.new,
);
