import '../entities/pokemon_model.dart';

abstract class PokemonRepository {
  Future<List<PokemonModel>> fetchPokemons(int offset, int limit);
}