
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_event.dart';
import '../widgets/listView_switch.dart';
import '../widgets/pokemons_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PokemonBloc>(context).add(FetchPokemonList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemYellow,
      appBar: AppBar(
        title: const Text('Pokemon'),
      ),
      body: Column(
        children: [
          const ListviewSwitch(),
           PokemonsList(),
        ],
      ),
    );
  }
}
