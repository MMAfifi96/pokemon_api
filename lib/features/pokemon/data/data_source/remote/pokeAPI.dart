// import 'package:dio/dio.dart';
// import 'package:pokemon_api/features/pokemon/data/data_models/pokemon_data_model.dart';
//
// class PokemonApiClient {
//   final Dio _dio = Dio();
//
//   Future<List<PokemonDataModel>> fetchPokemons() async {
//     try {
//       final response =
//           await _dio.get('https://pokeapi.co/api/v2/pokemon?limit=20');
//       if (response.statusCode == 200) {
//         List results = response.data['results'];
//
//         List<PokemonDataModel> pokemons = [];
//         for (var result in results) {
//           final pokemonResponse = await _dio.get(result['url']);
//           if (pokemonResponse.statusCode == 200) {
//             pokemons.add(PokemonDataModel.fromJson(pokemonResponse.data));
//           }
//         }
//         return pokemons;
//       } else {
//         throw Exception('Failed to load Pokémon list');
//       }
//     } catch (e) {
//       print(e.toString());
//       throw Exception('Failed to load Pokémon list');
//     }
//   }
// }

import 'package:dio/dio.dart';
import '../../data_models/pokemon_data_model.dart';

class PokemonApiClient {
  final Dio _dio = Dio();

  Future<List<PokemonDataModel>> fetchPokemons(int offset, int limit) async {
    try {
      // Perform API call
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit');

      // Print the entire response to inspect the structure
      print(response.data);

      if (response.statusCode == 200) {
        List results = response.data['results'];

        // Ensure every JSON entry is printed and handled safely
        return results.map((pokemonJson) {
          print("Pokemon JSON: $pokemonJson");
          return PokemonDataModel.fromJson(pokemonJson);
        }).toList();
      } else {
        throw Exception('Failed to load Pokémon list');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load Pokémon list');
    }
  }
}



