import 'package:flutter/material.dart';

class AcoesTextButton extends StatelessWidget {
  final Function onFunction;
  final String text;

  AcoesTextButton(
      {this.onFunction = defaultFunction, this.text = 'Cadastrar', super.key});

  double _altura = 0.0;

  @override
  Widget build(BuildContext context) {
    _altura = MediaQuery.of(context).size.height;

    return SizedBox(
      height: _altura * 0.07,
      child: ElevatedButton(
        onPressed: () => onFunction(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF910029),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFFDFFFF),
          ),
        ),
      ),
    );
  }

  static void defaultFunction() {}
}
