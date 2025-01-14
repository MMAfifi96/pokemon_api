import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/fetch_random_pokemon_usecase.dart';
import 'game_pokemon_event.dart';
import 'game_pokemon_state.dart';

class GamePokemonBloc extends Bloc<GamePokemonEvent, GamePokemonState> {
  final FetchRandomPokemonUseCase fetchRandomPokemonUseCase;

  GamePokemonBloc(this.fetchRandomPokemonUseCase)
      : super(GamePokemonInitial()) {
    on<FetchRandomPokemonEvent>((event, emit) async {
      emit(GamePokemonLoading());
      try {
        final pokemon = await fetchRandomPokemonUseCase();
        print('Fetched Pokémon: ${pokemon['name']}');
        emit(GamePokemonLoaded(
            name: pokemon['name']!, imageUrl: pokemon['image']!));
      } catch (e) {
        emit(GamePokemonError("Failed to fetch Pokémon."));
      }
    });
  }
}
