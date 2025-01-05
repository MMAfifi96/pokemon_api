import '../../domain/entities/pokemon_model.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../data_source/remote/pokeAPI.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApiClient apiClient;

  PokemonRepositoryImpl(this.apiClient);

  @override
  Future<List<PokemonModel>> fetchPokemons(int offset, int limit) async {
    final dataModels = await apiClient.fetchPokemons(offset, limit);
    return dataModels.map((dataModel) => PokemonModel(
      id: dataModel.id,
      name: dataModel.name,
      imageUrl: dataModel.imageUrl,
      baseExperience: dataModel.baseExperience,
    )).toList();
  }
}