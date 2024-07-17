import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class QuantidadeFormato extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,##0.00', 'pt_BR');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value =
        double.parse(newValue.text.replaceAll(RegExp(r'[^0-9]'), '')) / 100;
    String newText = '${_formatter.format(value)} kg';

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
          offset: newText.length -
              3), // Ajusta para posicionar o cursor corretamente
    );
  }
}
