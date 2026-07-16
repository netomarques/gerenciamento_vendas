import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final listaVendasProvider =
    NotifierProvider<ListaVendasNotifier, ListaVendasState>(
  ListaVendasNotifier.new,
);
