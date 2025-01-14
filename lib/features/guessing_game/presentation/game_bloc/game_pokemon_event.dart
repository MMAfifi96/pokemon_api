import 'package:equatable/equatable.dart';

abstract class GamePokemonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRandomPokemonEvent extends GamePokemonEvent {}
