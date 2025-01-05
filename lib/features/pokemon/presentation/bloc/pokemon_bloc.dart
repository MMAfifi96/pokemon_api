import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/features/pokemon/presentation/bloc/pokemone_state.dart';
import '../../domain/usecases/fetch_pokemons_usecase.dart';
import 'pokemon_event.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final FetchPokemonsUseCase fetchPokemons;

  PokemonBloc(this.fetchPokemons) : super(PokemonInitial()) {
    on<FetchPokemonList>((event, emit) async {
      emit(PokemonLoading());
      try {
        final pokemons = await fetchPokemons(0, 20);
        emit(PokemonLoaded(pokemons));
      } catch (e) {
        emit(PokemonError("Failed to fetch Pokemon list"));
      }
    });
  }
}