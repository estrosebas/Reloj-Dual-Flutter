import 'package:flutter/material.dart';
import 'dual_clock.dart';
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
        scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 60), // Cambia este color para ajustar el fondo del cuerpo
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const DualClock(), // Usa el widget DualClock aquí
    );
  }
}