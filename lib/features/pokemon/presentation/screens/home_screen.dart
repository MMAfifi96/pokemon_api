import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_event.dart';
import '../widgets/home_screen_widgets/listView_switch.dart';
import '../widgets/home_screen_widgets/pokemons_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGridView = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PokemonBloc>(context).add(FetchPokemonList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          children: [
            const Text(
              'Pokemon World',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 65,
              width: 70,
              child: Image.asset('assets/images/pikachu-logo-nbg.png'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      print('game');
                      GoRouter.of(context).goNamed('game');
                    },
                    child: Row(
                      children: [
                        Text('Guess The Pokemon'),
                        Text(
                          ' 🎮',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
                Expanded(
                  child: SizedBox(
                    width: 1,
                  ),
                ),
                ListviewSwitch(
                  value: isGridView,
                  onChanged: (value) {
                    setState(() {
                      isGridView = value;
                    });
                  },
                ),
              ],
            ),
          ),
          PokemonsList(isGridView: isGridView),
        ],
      ),
    );
  }
}
