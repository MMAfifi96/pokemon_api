import 'package:flutter/material.dart';

class GameTextInputRow extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onValidate;

  const GameTextInputRow({
    super.key,
    required this.textController,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: "Enter Pokémon name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 15, 0),
            child: InkWell(
              onTap: onValidate,
              child: const Text(
                '✅',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
