// class PokemonDataModel {
//   final int id;
//   final String name;
//   final int baseExperience;
//   final String imageUrl;
//
//   PokemonDataModel({
//     required this.id,
//     required this.name,
//     required this.baseExperience,
//     required this.imageUrl,
//   });
//
//   factory PokemonDataModel.fromJson(Map<String, dynamic> json) {
//     return PokemonDataModel(
//       id: json['id'],
//       name: json['name'],
//       baseExperience: json['base_experience'],
//       imageUrl: json['sprites']['front_default'] ?? '',
//     );
//   }
// }


class PokemonDataModel {
  final int id;
  final String name;
  final String imageUrl;
  final int baseExperience; // Add this field

  PokemonDataModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.baseExperience, // Add this field
  });

  factory PokemonDataModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String?;
    if (url == null) {
      throw Exception("Missing 'url' for Pokémon");
    }

    // Extract the ID from the URL
    final id = int.tryParse(url.split('/')[url.split('/').length - 2]) ?? 0;

    // Extract base experience safely
    final baseExperience = json['base_experience'] ?? 0; // Check for null

    return PokemonDataModel(
      id: id,
      name: json['name'] ?? 'Unknown',
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
      baseExperience: baseExperience, // Assign this value
    );
  }
}
