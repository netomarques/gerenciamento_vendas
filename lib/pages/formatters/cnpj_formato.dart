import 'package:flutter/services.dart';
import 'package:vendas_gerenciamento/pages/formatters/icpf_ou_cnpj.dart';

class CnpjFormato implements ICpfOuCnpj {
  @override
  int get tamanhoCampo => 14;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;

    if (newValueLength > tamanhoCampo) {
      return oldValue;
    }

    var selectionIndex = newValue.selection.end;
    var substrIndex = 0;
    final newText = StringBuffer();

    if (newValueLength >= 3) {
      newText.write('${newValue.text.substring(0, substrIndex = 2)}.');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newValueLength >= 6) {
      newText.write('${newValue.text.substring(2, substrIndex = 5)}.');
      if (newValue.selection.end >= 5) selectionIndex++;
    }
    if (newValueLength >= 9) {
      newText.write('${newValue.text.substring(5, substrIndex = 8)}/');
      if (newValue.selection.end >= 8) selectionIndex++;
    }
    if (newValueLength >= 13) {
      newText.write('${newValue.text.substring(8, substrIndex = 12)}-');
      if (newValue.selection.end >= 12) selectionIndex++;
    }
    if (newValueLength >= substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
