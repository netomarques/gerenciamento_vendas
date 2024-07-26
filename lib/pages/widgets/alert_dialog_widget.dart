import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlertDialogWidget extends StatelessWidget {
  final String msg;

  const AlertDialogWidget(this.msg, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF006940),
      title: const Text('Mensagem',
          style: TextStyle(color: Color(0xFFEB710A), fontSize: 16)),
      content: Text(msg,
          style: const TextStyle(color: Color(0xFFFDFFFF), fontSize: 20)),
      actions: [
        TextButton(
            onPressed: () => context.pop(),
            child: const Text("OK",
                style: TextStyle(color: Color(0xFFEB710A), fontSize: 16))),
      ],
    );
  }
}
