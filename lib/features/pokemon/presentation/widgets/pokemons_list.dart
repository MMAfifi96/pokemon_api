// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pokemon_api/features/pokemon/presentation/bloc/pokemone_state.dart';
// import '../bloc/pokemon_bloc.dart';
// import 'pokemon_card.dart';
//
// class PokemonsList extends StatelessWidget {
//   const PokemonsList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PokemonBloc, PokemonState>(
//       builder: (context, state) {
//         if (state is PokemonLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is PokemonLoaded) {
//           return SizedBox(
//             height: MediaQuery.sizeOf(context).height/1.5,
//             width: double.infinity,
//             child: ListView.builder(
//               itemCount: state.pokemons.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final pokemon = state.pokemons[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: PokemonCard(pokemon: pokemon),
//                 );
//               },
//             ),
//           );
//         } else if (state is PokemonError) {
//           return Center(child: Text(state.message));
//         } else {
//           return const Center(child: Text("No data available"));
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/features/pokemon/presentation/bloc/pokemone_state.dart';
import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_event.dart';
import 'pokemon_card.dart';

class PokemonsList extends StatefulWidget {
  const PokemonsList({super.key});

  @override
  _PokemonsListState createState() => _PokemonsListState();
}

class _PokemonsListState extends State<PokemonsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
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
          return SizedBox(
            height: MediaQuery.sizeOf(context).height / 1.5,
            width: double.infinity,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.pokemons.length,
              itemBuilder: (BuildContext context, int index) {
                final pokemon = state.pokemons[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: PokemonCard(pokemon: pokemon),
                );
              },
            ),
          );
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
