import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_api/features/pokemon/domain/usecases/fetch_pokemons_usecase.dart';
import 'config/routes/routes.dart';

import 'features/guessing_game/data/data_sources/game_pokemon_api_client.dart';
import 'features/guessing_game/data/repositories/game_pokemon_repository_impl.dart';
import 'features/guessing_game/domain/use_cases/fetch_random_pokemon_usecase.dart';
import 'features/guessing_game/presentation/game_bloc/game_pokemon_bloc.dart';
import 'features/pokemon/presentation/bloc/pokemon_bloc.dart';

void main() {
  final apiClient = GamePokemonApiClient();
  final repository = GamePokemonRepositoryImpl(apiClient);
  final fetchPokemonUseCase = FetchRandomPokemonUseCase(repository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PokemonBloc(fetchPokemonUseCase as FetchPokemonsUseCase),
        ),
        BlocProvider(
          create: (context) => GamePokemonBloc(fetchPokemonUseCase),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}
