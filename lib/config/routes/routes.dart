import 'package:go_router/go_router.dart';
import 'package:pokemon_api/features/pokemon/presentation/screens/home_screen.dart';
import 'package:pokemon_api/features/pokemon/presentation/screens/details_screen.dart';
import 'package:pokemon_api/features/pokemon/data/data_source/remote/pokeAPI.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/features/pokemon/presentation/bloc/pokemon_bloc.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => BlocProvider(
        create: (context) => PokemonBloc(PokemonApiClient()),
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/details/:id',
      name: 'details',
      builder: (context, state) {
        final id = state.params['id']!;
        return DetailsScreen(id: id);
      },
    ),
  ],
);
