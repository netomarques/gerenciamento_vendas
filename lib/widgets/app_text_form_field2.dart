import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField2 extends StatelessWidget {
  final String _hintText;
  final String _labelText;
  final TextInputType _textInputType;
  final Function _validator;
  final Function _onSaved;
  final Function? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final bool? isReadOnly;
  final List<TextInputFormatter>? formato;
  final String? initialValue;

  const AppTextFormField2(
    this._hintText,
    this._labelText,
    this._textInputType,
    this._validator,
    this._onSaved, {
    this.onChanged,
    this.onTap,
    this.controller,
    this.isReadOnly = false,
    this.formato,
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      style: _textStyle(const Color(0xFFEB710A)),
      decoration: InputDecoration(
        labelText: _labelText,
        labelStyle: _textStyle(const Color(0xFF006940)),
        hintText: _hintText,
        hintStyle: _textStyle(const Color(0xFFEB710A)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        filled: true,
        // fillColor: const Color(0xFFEB710A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: _estiloBorda(const Color(0xFF006940)),
        errorBorder: _estiloBorda(const Color(0xFF910029)),
        errorStyle: const TextStyle(
          color: Color(0xFF910029),
        ),
      ),
      keyboardType: _textInputType,
      validator: (value) => _validator(value),
      onSaved: (value) => _onSaved(value),
      onChanged: (value) => onChanged?.call(value),
      readOnly: isReadOnly!,
      onTap: onTap,
      inputFormatters: formato,
    );
  }

  _textStyle(Color color) {
    return TextStyle(
      fontSize: 14,
      color: color,
    );
  }

  _estiloBorda(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      ),
    );
  }
}
