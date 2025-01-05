import 'package:dio/dio.dart';
import '../../../domain/usecases/fetch_pokemons_usecase.dart';

class PokemonApiClient {
  final Dio _dio = Dio();

  Future<List<PokemonDataModel>> fetchPokemons(int offset, int limit) async {
    try {
      final response = await _dio.get(
        'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit',
      );
      if (response.statusCode == 200) {
        List results = response.data['results'];
        return results.map((pokemonJson) {
          return PokemonDataModel.fromJson(pokemonJson);
        }).toList();
      } else {
        throw Exception('Failed to load Pokémon list');
      }
    } catch (e) {
      throw Exception('Failed to load Pokémon list');
    }
  }
}