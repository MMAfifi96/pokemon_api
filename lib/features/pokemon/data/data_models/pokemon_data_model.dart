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

    return PokemonDataModel(
      id: id,
      name: json['name'] ?? 'Unknown',
      imageUrl:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
      baseExperience: json['base_experience'] ?? 0,
    );
  }
}