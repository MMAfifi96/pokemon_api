import '../../domain/repositories/game_pokemon_repository.dart';
import '../data_sources/game_pokemon_api_client.dart';

class GamePokemonRepositoryImpl implements GamePokemonRepository {
  final GamePokemonApiClient apiClient;

  GamePokemonRepositoryImpl(this.apiClient);

  @override
  Future<Map<String, String>> fetchRandomPokemon() {
    return apiClient.fetchRandomPokemon();
  }
}
