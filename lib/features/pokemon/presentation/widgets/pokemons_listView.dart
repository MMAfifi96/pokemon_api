import 'package:flutter/material.dart';
import 'package:pokemon_api/features/pokemon/data/data_models/pokemon_data_model.dart';
import 'package:pokemon_api/features/pokemon/presentation/widgets/pokemon_card.dart';

class PokemonListView extends StatelessWidget {
  final List<PokemonDataModel> pokemons;
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
