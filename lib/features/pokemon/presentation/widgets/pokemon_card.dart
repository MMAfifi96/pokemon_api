import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).pushNamed(
          'details',
          params: {'id': pokemon.name},
        );
      },
      child: Container(
        color: Colors.purple,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 75,
              width: 75,
              child: Image.network(
                pokemon.url,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Name: ${pokemon.name}', overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
