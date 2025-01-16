import 'package:flutter/material.dart';

class GameFeedbackMessage extends StatelessWidget {
  final String message;
  final Color color;

  const GameFeedbackMessage({
    super.key,
    required this.message,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        message,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
