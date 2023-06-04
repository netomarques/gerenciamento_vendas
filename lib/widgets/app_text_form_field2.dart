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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF006940),
      ),
      decoration: InputDecoration(
        labelText: _labelText,
        labelStyle: const TextStyle(fontSize: 14, color: Color(0xFF910029)),
        hintText: _hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFF006940),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        filled: true,
        fillColor: const Color(0xFFFDFFFF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: const BorderSide(
            color: Color(0xFF006940),
            width: 1.0,
          ),
        ),
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
}
