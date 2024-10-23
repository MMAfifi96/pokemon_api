import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_api/features/pokemon/data/data_models/pokemon_data_model.dart';

class PokemonCard extends StatelessWidget {
  final PokemonDataModel pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).pushNamed(
          'details',
          params: {'id': pokemon.id.toString()},
        );
      },
      child: Container(
        color: Colors.purple,
        padding: const EdgeInsets.all(8.0),
        child: Column( // Use a Column instead of a Row for better layout in grids
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: [
            // Constrain the image size
            SizedBox(
              height: 75,
              width: 75,
              child: Image.network(
                pokemon.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 8.0), // Add some spacing between image and text
            // Texts will dynamically take up space
            Text('ID: ${pokemon.id}', overflow: TextOverflow.ellipsis), // Prevent overflow
            Text('Name: ${pokemon.name}', overflow: TextOverflow.ellipsis), // Prevent overflow
            Text('Experience: ${pokemon.baseExperience}', overflow: TextOverflow.ellipsis), // Prevent overflow
          ],
        ),
      ),
    );
  }
}
