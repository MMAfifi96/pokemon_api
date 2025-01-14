import 'package:equatable/equatable.dart';

abstract class GamePokemonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GamePokemonInitial extends GamePokemonState {}

class GamePokemonLoading extends GamePokemonState {}

class GamePokemonLoaded extends GamePokemonState {
  final String name;
  final String imageUrl;

  GamePokemonLoaded({required this.name, required this.imageUrl});

  @override
  List<Object?> get props => [name, imageUrl];
}

class GamePokemonError extends GamePokemonState {
  final String message;

  GamePokemonError(this.message);

  @override
  List<Object?> get props => [message];
}
