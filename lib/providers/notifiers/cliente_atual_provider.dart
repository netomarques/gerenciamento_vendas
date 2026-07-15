import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/model/model.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final clienteAtualProvider = NotifierProvider.family
    .autoDispose<ClienteAtualNotifier, ClienteAtualState, Cliente>(
  ClienteAtualNotifier.new,
);
