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
                        color: Colors.red,
                        border: Border.all(width: 5, color: Colors.purple),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height / 3,
                      child: state is GamePokemonLoading
                          ? const Center(child: CircularProgressIndicator())
                          : state is GamePokemonLoaded
                              ? Image.network(
                                  state.imageUrl,
                                  fit: BoxFit.contain,
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
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                    ),
                    onPressed: () {
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
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter Pokémon name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 15, 0),
                        child: InkWell(
                          onTap: () {
                            print('Checking the answer...');
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
              ],
            ),
          );
        },
      ),
    );
  }
}
