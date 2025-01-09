import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import '../widgets/details_screen_widgets/pokemon_details_list.dart';
import '../widgets/details_screen_widgets/pokemon_images_carousel.dart';

class DetailsScreen extends StatefulWidget {
  final String id;

  const DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map<String, String> sprites = {};
  String pokemonName = '';
  List<String> abilities = [];
  List<String> types = [];
  List<Map<String, dynamic>> stats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPokemonDetails();
  }

  Future<void> _fetchPokemonDetails() async {
    try {
      var response =
          await Dio().get('https://pokeapi.co/api/v2/pokemon/${widget.id}');
      var data = response.data;

      setState(() {
        // Fetch sprites
        sprites = {
          'front_default': data['sprites']['front_default'],
          'back_default': data['sprites']['back_default'],
          'front_shiny': data['sprites']['front_shiny'],
          'back_shiny': data['sprites']['back_shiny'],
        };

        // Fetch Pokémon name
        pokemonName = data['name'];

        // Fetch abilities
        abilities = (data['abilities'] as List)
            .map((ability) => ability['ability']['name'] as String)
            .toList();

        // Fetch types
        types = (data['types'] as List)
            .map((type) => type['type']['name'] as String)
            .toList();

        // Fetch stats
        stats = (data['stats'] as List)
            .map((stat) => {
                  'name': stat['stat']['name'],
                  'value': stat['base_stat'],
                })
            .toList();

        isLoading = false;
      });
    } catch (error) {
      print('Error fetching Pokémon details: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          pokemonName.isNotEmpty ? pokemonName : 'Loading...',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Red section for carousel images
            PokemonImagesCarousel(
              sprites: sprites,
              isLoading: isLoading,
            ),

            const SizedBox(height: 10),

            // Green section for details
            Expanded(
              child: PokemonDetailsList(
                isLoading: isLoading,
                abilities: abilities,
                types: types,
                stats: stats,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
