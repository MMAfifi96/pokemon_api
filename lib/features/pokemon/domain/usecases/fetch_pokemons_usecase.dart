import '../entities/pokemon_model.dart';
import '../repositories/pokemon_repository.dart';

class FetchPokemonsUseCase {
  final PokemonRepository repository;

  FetchPokemonsUseCase(this.repository);

  Future<List<PokemonModel>> call(int offset, int limit) {
    return repository.fetchPokemons(offset, limit);
  }
}

// lib/features/pokemon/data/models/pokemon_data_model.dart
class PokemonDataModel {
  final int id;
  final String name;
  final String imageUrl;
  final int baseExperience;

  PokemonDataModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.baseExperience,
  });

  factory PokemonDataModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String?;
    if (url == null) {
      throw Exception("Missing 'url' for Pokémon");
    }

    final id = int.tryParse(url.split('/')[url.split('/').length - 2]) ?? 0;
    final baseExperience = json['base_experience'] ?? 0;

    return PokemonDataModel(
      id: id,
      name: json['name'] ?? 'Unknown',
      imageUrl:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
      baseExperience: baseExperience,
    );
  }
}