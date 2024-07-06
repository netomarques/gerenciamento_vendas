import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';

class AcoesTextButton extends StatelessWidget {
  final Function onFunction;
  final String text;

  const AcoesTextButton(
      {required this.onFunction, this.text = 'Cadastrar', super.key});

  @override
  Widget build(BuildContext context) {
    final Size sizeDevice = context.devicesize;

    return SizedBox(
      height: sizeDevice.height * 0.07,
      child: ElevatedButton(
        onPressed: () => onFunction(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEB710A),
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
}
