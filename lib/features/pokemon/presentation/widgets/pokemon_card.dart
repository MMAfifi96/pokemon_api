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
        print('Navigating to details page for ID: ${pokemon.id}');

        GoRouter.of(context).pushNamed(
          'details',
          params: {'id': pokemon.id.toString()},
        );
      },
      child: Container(
        color: Colors.purple,
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 75,
                width: 75,
                child: Image.network(
                  pokemon.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${pokemon.id}'),
                  Text('Name: ${pokemon.name}'),
                  Text('Base Experience: ${pokemon.baseExperience}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
