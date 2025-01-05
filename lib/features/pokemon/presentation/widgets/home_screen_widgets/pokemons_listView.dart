import 'package:flutter/material.dart';
import 'package:pokemon_api/features/pokemon/presentation/widgets/home_screen_widgets/pokemon_card.dart';
import '../../../domain/entities/pokemon_model.dart';

class PokemonListView extends StatelessWidget {
  final List<PokemonModel> pokemons;
  final ScrollController scrollController;

  const PokemonListView({
    super.key,
    required this.pokemons,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 1.5,
      width: double.infinity,
      child: ListView.builder(
        controller: scrollController,
        itemCount: pokemons.length,
        itemBuilder: (BuildContext context, int index) {
          final pokemon = pokemons[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: PokemonCard(pokemon: pokemon),
          );
        },
      ),
    );
  }
}