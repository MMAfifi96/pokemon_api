import 'package:flutter/material.dart';

class PokemonDetailsList extends StatelessWidget {
  final bool isLoading;
  final List<String> abilities;
  final List<String> types;
  final List<Map<String, dynamic>> stats;

  const PokemonDetailsList({
    super.key,
    required this.isLoading,
    required this.abilities,
    required this.types,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                // Abilities
                const Text(
                  'Abilities:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ...abilities.map((ability) => ListTile(
                      title: Text(ability),
                    )),

                // Types
                const SizedBox(height: 10),
                const Text(
                  'Types:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ...types.map((type) => ListTile(
                      title: Text(type),
                    )),

                // Stats
                const SizedBox(height: 10),
                const Text(
                  'Stats:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ...stats.map((stat) => ListTile(
                      title: Text('${stat['name']}: ${stat['value']}'),
                    )),
              ],
            ),
    );
  }
}
