// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pokemon_api/features/pokemon/presentation/bloc/pokemon_event.dart';
// import 'package:pokemon_api/features/pokemon/presentation/bloc/pokemone_state.dart';
// import '../../data/data_source/remote/pokeAPI.dart';
//
// class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
//   final PokemonApiClient apiClient;
//
//   PokemonBloc(this.apiClient) : super(PokemonInitial()) {
//     on<FetchPokemonList>((event, emit) async {
//       emit(PokemonLoading());
//       print("Fetching Pokémon list...");
//
//       try {
//         final pokemons = await apiClient.fetchPokemons();
//         print("Pokémon list fetched successfully.");
//         emit(PokemonLoaded(pokemons));
//       } catch (e) {
//         print("Error fetching Pokémon list: $e");
//         emit(PokemonError("Failed to fetch Pokémon list"));
//       }
//     });
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_source/remote/pokeAPI.dart';
import '../../data/data_models/pokemon_data_model.dart';
import 'pokemon_event.dart';
import 'pokemone_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonApiClient apiClient;
  int offset = 0;
  int limit = 20;
  bool isFetchingMore = false; // To avoid multiple triggers while fetching more

  PokemonBloc(this.apiClient) : super(PokemonInitial()) {
    on<FetchPokemonList>((event, emit) async {
      if (!isFetchingMore) {
        emit(PokemonLoading());
        try {
          // Fetch the first 20 Pokémon
          final pokemons = await apiClient.fetchPokemons(offset, limit);
          emit(PokemonLoaded(pokemons));
        } catch (e) {
          emit(PokemonError("Failed to fetch Pokemon list"));
        }
      }
    });

    on<FetchMorePokemons>((event, emit) async {
      if (!isFetchingMore) {
        isFetchingMore = true; // Prevent multiple triggers
        try {
          // Fetch the next set of Pokémon
          final morePokemons = await apiClient.fetchPokemons(offset, limit);
          offset += limit; // Increase offset for the next batch
          if (state is PokemonLoaded) {
            final currentPokemons = (state as PokemonLoaded).pokemons;
            emit(PokemonLoaded(currentPokemons + morePokemons)); // Append new Pokémon to the existing list
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
