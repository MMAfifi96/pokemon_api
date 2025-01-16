import 'package:flutter/material.dart';

class GameScrollButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GameScrollButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple),
        ),
        onPressed: onPressed,
        child: const Text(
          'Scroll 🔄',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
