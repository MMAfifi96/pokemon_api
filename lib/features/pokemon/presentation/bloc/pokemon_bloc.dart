import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_source/remote/pokeAPI.dart';
import '../../data/data_models/pokemon_data_model.dart';
import 'pokemon_event.dart';
import 'pokemone_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonApiClient apiClient;
  int offset = 0;
  int limit = 20;
  bool isFetchingMore = false;

  PokemonBloc(this.apiClient) : super(PokemonInitial()) {
    on<FetchPokemonList>((event, emit) async {
      if (!isFetchingMore) {
        emit(PokemonLoading());
        try {
          final pokemons = await apiClient.fetchPokemons(offset, limit);
          emit(PokemonLoaded(pokemons));
        } catch (e) {
          emit(PokemonError("Failed to fetch Pokemon list"));
        }
      }
    });

    on<FetchMorePokemons>((event, emit) async {
      if (!isFetchingMore) {
        isFetchingMore = true;
        try {
          final morePokemons = await apiClient.fetchPokemons(offset, limit);
          offset += limit;
          if (state is PokemonLoaded) {
            final currentPokemons = (state as PokemonLoaded).pokemons;
            emit(PokemonLoaded(currentPokemons + morePokemons));
          }
        } catch (e) {
          emit(PokemonError("Failed to load more Pokémon"));
        } finally {
          isFetchingMore = false;
        }
      }
    });
  }
}
