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

      decoration: BoxDecoration(
          color: Colors.purple.shade100,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.purple.shade200,
            width: 5,
          )),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                const Text(
                  '- Abilities:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.purple),
                ),
                ...abilities.map((ability) => ListTile(
                      title: Text(ability),
                    )),
                const SizedBox(height: 10),
                const Text(
                  '- Types:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.purple),
                ),
                ...types.map((type) => ListTile(
                      title: Text(type),
                    )),
                const SizedBox(height: 10),
                const Text(
                  '- Stats:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.purple),
                ),
                ...stats.map((stat) => ListTile(
                      title: Text('${stat['name']}: ${stat['value']}'),
                    )),
              ],
            ),
    );
  }
}
