import 'package:flutter/services.dart';
import 'package:vendas_gerenciamento/pages/formatters/icpf_ou_cnpj.dart';

class CpfOuCnpjFormato extends TextInputFormatter {

  final List<ICpfOuCnpj> _formatters;

  CpfOuCnpjFormato(this._formatters);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final delegatedFormatter = _formatters.firstWhere((formatter) {
      final newValueLength = newValue.text.length;
      final maxLength = formatter.tamanhoCampo;
      return newValueLength <= maxLength;
    }, orElse: () {
      return _formatters.first;
    });
    return delegatedFormatter.formatEditUpdate(oldValue, newValue);
  }

}