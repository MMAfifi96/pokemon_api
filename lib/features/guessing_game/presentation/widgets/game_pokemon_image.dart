import 'dart:ui';
import 'package:flutter/material.dart';
import '../game_bloc/game_pokemon_state.dart';

class GamePokemonImage extends StatelessWidget {
  final GamePokemonState state;
  final bool isBlurred;

  const GamePokemonImage({
    super.key,
    required this.state,
    required this.isBlurred,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      ? ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0)
                      : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                  child: Image.network(
                    (state as GamePokemonLoaded).imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                if (isBlurred)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.1),
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
    );
  }
}
