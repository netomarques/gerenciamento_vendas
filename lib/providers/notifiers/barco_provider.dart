import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/providers/providers.dart';

final barcoProvider =
    NotifierProvider.family.autoDispose<BarcoNotifier, BarcoState, int>(
  BarcoNotifier.new,
);
