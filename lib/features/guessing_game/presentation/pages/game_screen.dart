import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Guess the Pokemon  🎮',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(width: 5, color: Colors.purple),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height / 3,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.purple),
                ),
                onPressed: () {
                  print('Scrolling...');
                },
                child: Text(
                  'Scroll 🔄',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
            child: Row(
              children: [
                const Expanded(child: TextField()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 15, 0),
                  child: InkWell(
                    onTap: () {
                      print('checking the answer...');
                    },
                    child: Text(
                      '✅',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
