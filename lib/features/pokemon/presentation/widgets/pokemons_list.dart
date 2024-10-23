import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/features/pokemon/presentation/bloc/pokemone_state.dart';
import 'package:pokemon_api/features/pokemon/presentation/widgets/pokemons_gridView.dart';
import 'package:pokemon_api/features/pokemon/presentation/widgets/pokemons_listView.dart';
import '../bloc/pokemon_event.dart';
import '../bloc/pokemon_bloc.dart';

class PokemonsList extends StatefulWidget {
  final bool isGridView;

  const PokemonsList({super.key, required this.isGridView});

  @override
  _PokemonsListState createState() => _PokemonsListState();
}

class _PokemonsListState extends State<PokemonsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<PokemonBloc>().add(FetchMorePokemons());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoading && state is! PokemonLoaded) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokemonLoaded) {
          if (widget.isGridView) {
            return PokemonGridView(
              pokemons: state.pokemons,
              scrollController: _scrollController,
            );
          } else {
            return PokemonListView(
              pokemons: state.pokemons,
              scrollController: _scrollController,
            );
          }
        } else if (state is PokemonError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
