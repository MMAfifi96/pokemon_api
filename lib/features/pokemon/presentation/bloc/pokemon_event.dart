// import 'package:equatable/equatable.dart';
//
// abstract class PokemonEvent extends Equatable {
//   const PokemonEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class FetchPokemonList extends PokemonEvent {}

import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonList extends PokemonEvent {}

class FetchMorePokemons extends PokemonEvent {}
