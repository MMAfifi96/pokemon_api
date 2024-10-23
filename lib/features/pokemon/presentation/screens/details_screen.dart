import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatefulWidget {
  final String id;

  const DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map<String, String> sprites = {};
  String pokemonName = '';
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
        sprites = {
          'front_default': data['sprites']['front_default'],
          'back_default': data['sprites']['back_default'],
          'front_shiny': data['sprites']['front_shiny'],
          'back_shiny': data['sprites']['back_shiny'],
        };
        pokemonName = data['name'];
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
    final screenWidth = MediaQuery.sizeOf(context).width;

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
            Container(
              height: MediaQuery.sizeOf(context).height / 4,
              width: screenWidth,
              color: Colors.red,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : sprites.isNotEmpty
                      ? CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.sizeOf(context).height / 4,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 2),
                          ),
                          items: sprites.entries.map((sprite) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.network(sprite.value,
                                    fit: BoxFit.contain);
                              },
                            );
                          }).toList(),
                        )
                      : const Center(child: Text("No sprites available")),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.green,
              height: MediaQuery.sizeOf(context).height / 1.8,
              width: screenWidth,
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Detail item #$index'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
