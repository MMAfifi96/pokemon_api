import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/features/pokemon/presentation/bloc/pokemone_state.dart';
import '../../domain/usecases/fetch_pokemons_usecase.dart';
import 'pokemon_event.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final FetchPokemonsUseCase fetchPokemonsUseCase;
  int offset = 0;
  final int limit = 20;

  PokemonBloc(this.fetchPokemonsUseCase) : super(PokemonInitial()) {
    on<FetchPokemonList>((event, emit) async {
      emit(PokemonLoading());
      try {
        final pokemons = await fetchPokemonsUseCase(offset, limit);
        emit(PokemonLoaded(pokemons));
      } catch (e) {
        emit(PokemonError("Failed to fetch Pokémon list"));
      }
    });

    on<FetchMorePokemons>((event, emit) async {
      try {
        offset += limit;
        final morePokemons = await fetchPokemonsUseCase(offset, limit);
        if (state is PokemonLoaded) {
          final currentPokemons = (state as PokemonLoaded).pokemons;
          emit(PokemonLoaded(currentPokemons + morePokemons));
        }
      } catch (e) {
        emit(PokemonError("Failed to fetch more Pokémon"));
      }
    });
  }
}
