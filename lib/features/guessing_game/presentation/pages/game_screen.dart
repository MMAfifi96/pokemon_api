import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_bloc/game_pokemon_bloc.dart';
import '../game_bloc/game_pokemon_event.dart';
import '../game_bloc/game_pokemon_state.dart';
import '../widgets/game_pokemon_image.dart';

import '../widgets/game_feedback_message.dart';
import '../widgets/scroll_button.dart';
import '../widgets/text_input_field.dart';

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
                GamePokemonImage(
                  state: state,
                  isBlurred: isBlurred,
                ),
                GameScrollButton(
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
                ),
                GameTextInputRow(
                  textController: _textController,
                  onValidate: () {
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
                        answerFeedbackMessage = "Incorrect 😢. Try again!";
                        answerFeedbackColor = Colors.red;
                      });
                      print("Incorrect 😢. Try again!");
                    }
                  },
                ),
                if (answerFeedbackMessage != null)
                  GameFeedbackMessage(
                    message: answerFeedbackMessage!,
                    color: answerFeedbackColor,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
