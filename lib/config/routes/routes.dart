import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/features/pokemon/domain/entities/pokemon_model.dart';
import 'package:pokemon_api/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_api/features/pokemon/presentation/screens/home_screen.dart';
import 'package:pokemon_api/features/pokemon/presentation/screens/details_screen.dart';
import 'package:pokemon_api/features/pokemon/domain/usecases/fetch_pokemons_usecase.dart';
import 'package:pokemon_api/features/pokemon/data/data_source/remote/pokeAPI.dart';
import 'package:pokemon_api/features/pokemon/presentation/bloc/pokemon_bloc.dart';
import '../../features/pokemon/data/repositories/pokeApi_repository_impl.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => BlocProvider(
        create: (context) {
          final apiClient = PokemonApiClient();
          final repository = PokemonRepositoryImpl(apiClient ); // Correct usage
          final fetchPokemonsUseCase = FetchPokemonsUseCase(repository as PokemonRepository); // Correct usage
          return PokemonBloc(fetchPokemonsUseCase ); // Correct usage
        },
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/details/:id',
      name: 'details',
      builder: (context, state) {
        final id = int.parse(state.params['id']!);
        return DetailsScreen(id: id.toString());
      },
    ),
  ],
);
