import '../repositories/game_pokemon_repository.dart';

class FetchRandomPokemonUseCase {
  final GamePokemonRepository repository;

  FetchRandomPokemonUseCase(this.repository);

  Future<Map<String, String>> call() {
    return repository.fetchRandomPokemon();
  }
}
