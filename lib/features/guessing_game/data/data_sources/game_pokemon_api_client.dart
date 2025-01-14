import 'package:dio/dio.dart';

class GamePokemonApiClient {
  final Dio _dio = Dio();

  Future<Map<String, String>> fetchRandomPokemon() async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon?limit=1000');
      final results = response.data['results'] as List;

      final randomPokemon = (results..shuffle()).first;
      final detailsResponse = await _dio.get(randomPokemon['url']);
      final details = detailsResponse.data;

      return {
        'name': details['name'],
        'image': details['sprites']['front_default'],
      };
    } catch (e) {
      throw Exception('Failed to fetch random Pokémon: $e');
    }
  }
}
