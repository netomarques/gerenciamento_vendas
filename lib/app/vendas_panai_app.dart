import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendas_gerenciamento/config/config.dart';
import 'package:vendas_gerenciamento/utils/build_material_color.dart';

class VendasPanaiApp extends ConsumerWidget {
  const VendasPanaiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(routesProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: BuildMaterialColor(
          const Color(0xFF006940),
        ),
        scaffoldBackgroundColor: const Color(0xFFFDFFFF),
      ),
      routerConfig: routeConfig,
    );
  }
}
