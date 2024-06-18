import 'package:flutter/material.dart';

class ImageFullscreen extends StatelessWidget {
  final String imagePath;

  const ImageFullscreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagen Completa'),
      ),
      body: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
