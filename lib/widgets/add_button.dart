import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //color: const Color(0xffFDFFFF),
        //color: Colors.black,
        margin: const EdgeInsets.all(10),
        constraints: const BoxConstraints.expand(height: 50),
        child: TextButton(
          style: TextButton.styleFrom( backgroundColor: Colors.blue),
          onPressed: onPressed,
          child: const Text('ADD'),
        ),
      ),
    );
  }
}