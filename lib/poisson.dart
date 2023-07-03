import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des poissons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Poisson(),
    );
  }
}

class Poisson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des poissons'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.details),
            title: Text('Détails des poissons'),
            subtitle: Text('Voir les informations sur vos poissons'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FishDetailsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Alimentation des poissons'),
            subtitle:
                Text('Gérer la quantité de nourriture quotidienne nécessaire'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FishFeedingPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Les Taches'),
            subtitle: Text(
                'Exécutez ces taches pour la bonne croissaance des poissons'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EducationalResourcesPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FishWeightChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Récapitulatif des poissons'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tilapia.png', // Replace with your fish image asset path
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Étape actuelle:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Stade de croissance',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.fitness_center, size: 40),
                    SizedBox(height: 10),
                    Text(
                      'Poids actuel',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '100 g',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.local_dining, size: 40),
                    SizedBox(height: 10),
                    Text(
                      'Nourriture',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '10 g',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FishDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails des poissons'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 50.0),
          FishCard(
            fishName: 'Tilapia',
            fishImage:
                'assets/images/poisson.png', // Replace with actual image path
            currentWeight: '40 g',
            age: '6 mois',
            foodQuantity: '300 g/jour',
            totalNumber: 2000,
          ),
          SizedBox(height: 16.0),
          Image.asset(
            'assets/images/tilapia.png', // Replace with your fish image asset path
            width: 200,
            height: 200,
          ),

          // Add more FishCard widgets for each fish type
        ],
      ),
    );
  }
}

class FishCard extends StatelessWidget {
  final String fishName;
  final String fishImage;
  final String currentWeight;
  final String age;
  final String foodQuantity;
  final int totalNumber;

  FishCard({
    required this.fishName,
    required this.fishImage,
    required this.currentWeight,
    required this.age,
    required this.foodQuantity,
    required this.totalNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              fishImage,
              width: 100,
              height: 100,
            ),
            SizedBox(height: 16.0),
            Text(
              fishName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.fitness_center, size: 20),
                SizedBox(width: 8.0),
                Text('Poids actuel: $currentWeight'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 20),
                SizedBox(width: 8.0),
                Text('Âge: $age'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.restaurant_menu, size: 20),
                SizedBox(width: 8.0),
                Text('Quantité de nourriture: $foodQuantity'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.group, size: 20),
                SizedBox(width: 8.0),
                Text('Nombre total: $totalNumber'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FishFeedingPage extends StatelessWidget {
  final List<FishType> fishTypes = [
    FishType(
      name: 'Tilapia',
      nutrientQuantity: 300,
    ),
    // Add more fish types as needed
  ];

  final List<EvolutionStage> evolutionStages = [
    EvolutionStage(
      stage: 'Étape 1',
      nutrientQuantity: 300,
    ),
    EvolutionStage(
      stage: 'Étape 2',
      nutrientQuantity: 400,
    ),
    // Add more evolution stages as needed
  ];

  final int plantCount = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculateur de Nutriments'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sélectionnez le type de poisson:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<FishType>(
                decoration: InputDecoration(
                  labelText: 'Type de poisson',
                  border: OutlineInputBorder(),
                ),
                value: fishTypes[0],
                items: fishTypes.map((FishType fishType) {
                  return DropdownMenuItem<FishType>(
                    value: fishType,
                    child: Text(fishType.name),
                  );
                }).toList(),
                onChanged: (FishType? selectedFishType) {
                  // Handle selected fish type
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Âge du poisson:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Âge du poisson',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String? age) {
                  // Handle entered age
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Nombre de poissons:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre de poissons',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String? fishCount) {
                  // Handle entered fish count
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Nombre de plantes:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                plantCount.toString(),
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // Calculate nutrient quantity
                },
                child: Text('Calculer'),
              ),
              SizedBox(height: 32.0),
              Text(
                'Étapes d\'évolution et quantité de nutriments:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: evolutionStages.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.adjust),
                    title: Text(evolutionStages[index].stage),
                    trailing: Text(
                      '${evolutionStages[index].nutrientQuantity} g',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FishType {
  final String name;
  final int nutrientQuantity;

  FishType({
    required this.name,
    required this.nutrientQuantity,
  });
}

class EvolutionStage {
  final String stage;
  final int nutrientQuantity;

  EvolutionStage({
    required this.stage,
    required this.nutrientQuantity,
  });
}

class Tache {
  final String name;
  final String image;
  bool isCompleted;

  Tache({
    required this.name,
    required this.image,
    this.isCompleted = false,
  });
}

class EvolutionStep {
  final String name;
  final List<Tache> tasks;
  final String resultImage;

  EvolutionStep({
    required this.name,
    required this.tasks,
    required this.resultImage,
  });
}

class TaskListPage extends StatefulWidget {
  final List<Tache> tasks;

  TaskListPage({required this.tasks});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Checkbox(
            value: widget.tasks[index].isCompleted,
            onChanged: (bool? value) {
              setState(() {
                widget.tasks[index].isCompleted = value ?? false;
              });
            },
          ),
          title: Row(
            children: [
              Text(widget.tasks[index].name),
              SizedBox(width: 8.0),
              if (widget.tasks[index].isCompleted)
                Icon(Icons.check, color: Colors.green),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TaskDetailsPage(task: widget.tasks[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class TaskDetailsPage extends StatelessWidget {
  final Tache task;

  TaskDetailsPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              task.image,
              width: 200.0,
              height: 200.0,
            ),
            SizedBox(height: 16.0),
            Text(
              task.name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Status: ${task.isCompleted ? 'Completed' : 'Not Completed'}',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class EducationalResourcesPage extends StatelessWidget {
  final List<EvolutionStep> evolutionSteps = [
    EvolutionStep(
      name: 'Étape 1 : Choix des espèces de poissons',
      tasks: [
        Tache(
          name:
              'Sélection d\'espèces de poissons adaptées à l\'aquaponie, telles que le tilapia, la truite, le poisson-chat, etc',
          image: 'assets/images/tilapia.png',
        ),
        Tache(
          name: 'Transport sûr des juvéniles jusqu\'au système d\'aquaponie',
          image: 'assets/images/tilapia.png',
        ),
      ],
      resultImage: 'assets/images/poisson_etape.jpg',
    ),
    EvolutionStep(
      name: 'Installation et démarrage du système : ',
      tasks: [
        Tache(
          name: 'Mise en place des bassins pour les poissons.',
          image: 'assets/images/renverser.png',
        ),
        Tache(
          name:
              'Mise en route du système de filtration et de la pompe pour assurer la circulation de l\'eau.',
          image: 'assets/images/tilapia.png',
        ),
        Tache(
          name:
              'Intégration des poissons dans les bassins et ajustement des paramètres de l\'eau.',
          image: 'assets/images/tilapia.png',
        ),
      ],
      resultImage: 'assets/images/insta.jpg',
    ),
    EvolutionStep(
      name: 'Alimentation des poissons : ',
      tasks: [
        Tache(
          name:
              'Surveiller la quantité d\'aliment donnée et ajuster en fonction de la croissance des poissons.',
          image: 'assets/images/tilapia.png',
        ),
        Tache(
          name:
              'Veiller à ce que les poissons consomment tout l\'aliment dans un délai raisonnable pour éviter une accumulation excessive de nutriments dans le système.',
          image: 'assets/images/tilapia.png',
        ),
      ],
      resultImage: 'assets/images/alimentation_poisson.png',
    ),
    EvolutionStep(
      name: 'Maintenance du système : ',
      tasks: [
        Tache(
          name:
              'Effectuer des opérations d\'entretien régulières, telles que le nettoyage des filtres, le remplacement de l\'eau évaporée et la réparation des équipements défectueux',
          image: 'assets/images/tilapia.png',
        ),
        Tache(
          name:
              'Éliminer les déchets organiques et les sédiments du système pour maintenir une bonne santé de l\'aquaponie.',
          image: 'assets/images/tilapia.png',
        ),
      ],
      resultImage: 'assets/images/maintenance.png',
    ),
    // Add more evolution steps if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Étapes d\'évolution des poissons:'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: evolutionSteps.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    title: Text(
                      evolutionSteps[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Tâches:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      TaskListPage(tasks: evolutionSteps[index].tasks),
                      SizedBox(height: 8.0),
                      Image.asset(
                        evolutionSteps[index].resultImage,
                        width: 200.0,
                        height: 200.0,
                      ),
                      SizedBox(height: 16.0),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EducationalResourcesPage(),
  ));
}
