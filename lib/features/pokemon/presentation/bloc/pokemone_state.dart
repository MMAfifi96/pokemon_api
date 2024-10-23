import 'package:equatable/equatable.dart';
import 'package:pokemon_api/features/pokemon/data/data_models/pokemon_data_model.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<PokemonDataModel> pokemons;

  const PokemonLoaded(this.pokemons);

  @override
  List<Object> get props => [pokemons];
}

class PokemonError extends PokemonState {
  final String message;

  const PokemonError(this.message);

  @override
  List<Object> get props => [message];
}
