import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_bloc/game_pokemon_bloc.dart';
import '../game_bloc/game_pokemon_event.dart';
import '../game_bloc/game_pokemon_state.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isBlurred = true;
  final TextEditingController _textController = TextEditingController();
  String? answerFeedbackMessage;
  Color answerFeedbackColor = Colors.transparent;

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
      body: BlocBuilder<GamePokemonBloc, GamePokemonState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        border: Border.all(width: 5, color: Colors.purple),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height / 3,
                      child: state is GamePokemonLoading
                          ? const Center(child: CircularProgressIndicator())
                          : state is GamePokemonLoaded
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      ImageFiltered(
                                        imageFilter: isBlurred
                                            ? ImageFilter.blur(
                                                sigmaX: 5.0,
                                                sigmaY: 5.0,
                                              )
                                            : ImageFilter.blur(
                                                sigmaX: 0.0,
                                                sigmaY: 0.0,
                                              ),
                                        child: Image.network(
                                          state.imageUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                      if (isBlurred)
                                        Positioned.fill(
                                          child: Container(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    "Press Scroll 🔄 to start!",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
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
                      setState(() {
                        isBlurred = true;
                        _textController.clear();
                        answerFeedbackMessage = null;
                        answerFeedbackColor = Colors.transparent;
                      });
                      context
                          .read<GamePokemonBloc>()
                          .add(FetchRandomPokemonEvent());
                    },
                    child: const Text(
                      'Scroll 🔄',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            hintText: "Enter Pokémon name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 15, 0),
                        child: InkWell(
                          onTap: () {
                            if (state is GamePokemonLoaded &&
                                _textController.text.trim().toLowerCase() ==
                                    state.name.toLowerCase()) {
                              setState(() {
                                isBlurred = false;
                                answerFeedbackMessage =
                                    "Correct! 💪🏼😉 \nPokémon Name: ${state.name}";
                                answerFeedbackColor = Colors.green;
                              });
                              print("Correct! 💪🏼😉 Pokémon Name: ${state.name}");
                            } else {
                              setState(() {
                                answerFeedbackMessage =
                                    "Incorrect 😢. Try again!";
                                answerFeedbackColor = Colors.red;
                              });
                              print("Incorrect 😢. Try again!");
                            }
                          },
                          child: const Text(
                            '✅',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (answerFeedbackMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      answerFeedbackMessage!,
                      style: TextStyle(
                        color: answerFeedbackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
