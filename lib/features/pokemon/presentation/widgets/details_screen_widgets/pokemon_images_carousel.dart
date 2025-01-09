import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonImagesCarousel extends StatelessWidget {
  final Map<String, String> sprites;
  final bool isLoading;

  const PokemonImagesCarousel({
    super.key,
    required this.sprites,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
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
          autoPlayInterval: const Duration(seconds: 2),
        ),
        items: sprites.entries.map((sprite) {
          return Builder(
            builder: (BuildContext context) {
              return CachedNetworkImage(
                imageUrl: sprite.value,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error, size: 40, color: Colors.red),
              );
            },
          );
        }).toList(),
      )
          : const Center(child: Text("No sprites available")),
    );
  }
}
