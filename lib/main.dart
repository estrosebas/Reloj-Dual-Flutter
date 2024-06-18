import 'package:flutter/material.dart';
import 'dual_clock.dart';
import 'image_gallery.dart'; // Importa el nuevo archivo

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 72, 45, 119)),
        scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 60),
      ),
      home: const MyHomePage(title: 'Sebas Flutter Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Galería de Imágenes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ImageGallery()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 30, 30, 60), Color.fromARGB(255, 72, 45, 119)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const DualClock(), // Usa el widget DualClock aquí
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para el botón flotante
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
