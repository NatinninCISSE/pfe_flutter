import 'package:flutter/material.dart';
import 'package:flutter_aisa/bottom-bar.dart';
import 'package:flutter/painting.dart';

class PlantDetailsPage extends StatelessWidget {
  final String plantName;
  final String imageUrl;
  final String description;

  const PlantDetailsPage({
    super.key,
    required this.plantName,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plantName),
      ),
      body: Column(
        children: [
          Image.network(imageUrl),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Ajoutez ici la logique pour prendre une photo de la plante et effectuer une analyse
            },
            child: const Text('Analyser la plante'),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Naviguez vers la page des détails de la plante
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlantDetailsPage(
                  plantName: 'Tomate',
                  imageUrl:
                      'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                  description: 'Description de la tomate...',
                ),
              ),
            );
          },
          child: const Text('Voir les détails de la plante'),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Agricole',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BottomTabs(),
    );
  }
}
