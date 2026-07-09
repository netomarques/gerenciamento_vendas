import 'package:flutter/material.dart';

MaterialColor buildMaterialColor(Color color) {
  final List<double> strengths = [.05];
  final Map<int, Color> swatch = {};

  final int r = (color.r * 255).round().clamp(0, 255);
  final int g = (color.g * 255).round().clamp(0, 255);
  final int b = (color.b * 255).round().clamp(0, 255);

  for (int i = 1; i < 10; i++) {
    strengths.add(i * 0.1);
  }

  for (final double strength in strengths) {
    final double delta = 0.5 - strength;

    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((delta < 0 ? r : (255 - r)) * delta).round(),
      g + ((delta < 0 ? g : (255 - g)) * delta).round(),
      b + ((delta < 0 ? b : (255 - b)) * delta).round(),
      1,
    );
  }

  return MaterialColor(color.toARGB32(), swatch);
}
