import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonList extends PokemonEvent {
  const FetchPokemonList();
}

class FetchMorePokemons extends PokemonEvent {
  const FetchMorePokemons();
}