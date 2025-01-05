import 'package:flutter/material.dart';
import '../../domain/entities/pokemon_model.dart';
import 'pokemon_card.dart';

class PokemonGridView extends StatelessWidget {
  final List<PokemonModel> pokemons;
  final ScrollController scrollController;

  const PokemonGridView({
    super.key,
    required this.pokemons,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 1.5,
      width: double.infinity,
      child: GridView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: pokemons.length,
        itemBuilder: (BuildContext context, int index) {
          final pokemon = pokemons[index];
          return PokemonCard(pokemon: pokemon);
        },
      ),
    );
  }
}