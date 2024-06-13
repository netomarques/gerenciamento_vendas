import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/app/vendas_panai_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: VendasPanaiApp(),
    ),
  );
}
