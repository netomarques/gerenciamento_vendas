import 'package:flutter/material.dart';
import 'package:vendas_gerenciamento/utils/extensions.dart';

class AcoesTextButton extends StatelessWidget {
  final Function onFunction;
  final bool carregando;
  final String text;

  const AcoesTextButton(
      {required this.onFunction,
      required this.carregando,
      this.text = 'Cadastrar',
      super.key});

  @override
  Widget build(BuildContext context) {
    final Size sizeDevice = context.devicesize;

    return SizedBox(
      height: sizeDevice.height * 0.07,
      width: sizeDevice.width * 0.425,
      child: ElevatedButton(
        onPressed: () => carregando ? {} : onFunction(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEB710A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: carregando
            ? const Center(child: CircularProgressIndicator())
            : Text(
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
