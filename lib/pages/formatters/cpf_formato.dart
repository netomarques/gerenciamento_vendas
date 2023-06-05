import 'package:flutter/services.dart';
import 'package:vendas_gerenciamento/pages/formatters/icpf_ou_cnpj.dart';

class CpfFormato implements ICpfOuCnpj {
  @override
  int get tamanhoCampo => 11;

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

    if (newValueLength >= 4) {
      newText.write('${newValue.text.substring(0, substrIndex = 3)}.');
      if (newValue.selection.end >= 3) selectionIndex++;
    }
    if (newValueLength >= 7) {
      newText.write('${newValue.text.substring(3, substrIndex = 6)}.');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newValueLength >= 10) {
      newText.write('${newValue.text.substring(6, substrIndex = 9)}-');
      if (newValue.selection.end >= 9) selectionIndex++;
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
