import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Conseils extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conseils d\'aquaponie'),
      ),
      body: ListView(
        children: [
          _buildSection(
            'Dispositif d\'aquaponie',
            'Voici quelques conseils pour mettre en place un dispositif d\'aquaponie :',
            [
              'Choisissez un emplacement approprié pour votre système d\'aquaponie.',
              'Installez correctement les réservoirs pour les poissons et les plantes.',
              'Assurez-vous d\'avoir une bonne circulation d\'eau et d\'oxygène dans le système.',
              'Surveillez régulièrement la qualité de l\'eau pour maintenir un environnement sain pour les poissons et les plantes.',
            ],
          ),
          _buildSection(
            'Cultures',
            'Voici quelques conseils pour cultiver des plantes en aquaponie :',
            [
              'Choisissez des plantes adaptées à la culture en aquaponie, comme la laitue, les herbes aromatiques et les légumes à feuilles.',
              'Utilisez un substrat approprié pour soutenir la croissance des plantes.',
              'Fournissez les nutriments nécessaires aux plantes en surveillant le pH et en ajoutant des fertilisants si nécessaire.',
              'Taillez régulièrement les plantes pour favoriser une croissance saine.',
            ],
          ),
          _buildSection(
            'Poissons',
            'Voici quelques conseils pour élever des poissons en aquaponie :',
            [
              'Choisissez des espèces de poissons adaptées à l\'aquaponie, comme le tilapia ou la truite.',
              'Surveillez la qualité de l\'eau pour maintenir des conditions optimales pour les poissons.',
              'Fournissez une alimentation équilibrée et appropriée pour les poissons.',
              'Surveillez la croissance et la santé des poissons et réagissez rapidement en cas de problèmes.',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String description, List<String> tips) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(description),
          SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tips.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.check),
              title: Text(tips[index]),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Conseils(),
  ));
}
