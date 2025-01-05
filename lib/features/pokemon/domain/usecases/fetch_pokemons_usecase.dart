import '../entities/pokemon_model.dart';
import '../repositories/pokemon_repository.dart';

class FetchPokemonsUseCase {
  final PokemonRepository repository;

  FetchPokemonsUseCase(this.repository);

  Future<List<PokemonModel>> call(int offset, int limit) {
    return repository.fetchPokemons(offset, limit);
  }
}