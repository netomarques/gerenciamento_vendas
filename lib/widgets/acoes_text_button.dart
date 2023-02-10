import 'package:flutter/material.dart';

class AcoesTextButton extends StatelessWidget {
  const AcoesTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff910029),
      ),
      child: TextButton(
        onPressed: () => {},
        child: const Text(
          'Cadastrar',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFDFFFF),
          ),
        ),
      ),
    );
  }
}
