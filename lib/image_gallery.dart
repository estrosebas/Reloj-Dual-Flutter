import 'package:flutter/material.dart';
import 'image_fullscreen.dart'; // Importa la nueva pantalla

class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de paths de las imágenes en assets
    final List<String> imageUrls = [
      'assets/images/horario-bffa.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galería de Imágenes'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageFullscreen(imagePath: imageUrls[index]),
                ),
              );
            },
            child: Card(
              child: Image.asset(
                imageUrls[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}
