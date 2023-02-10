import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String _hintText;
  final String _labelText;

  const AppTextFormField(this._hintText, this._labelText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: const Color(0xffFDFFFF),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff910029),
        ),
        decoration: InputDecoration(
          labelText: _labelText,
          labelStyle: const TextStyle(fontSize: 14, color: Color(0xFF006940)),
          hintText: _hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xff910029),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
