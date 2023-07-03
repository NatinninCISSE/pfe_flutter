import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Tache {
  final String name;
  final String image;

  Tache({
    required this.name,
    required this.image,
  });
}

class Etape {
  final String name;
  final String image;
  final String description;
  final List<Tache> tasks;

  Etape({
    required this.name,
    required this.image,
    required this.description,
    required this.tasks,
  });
}

class TaskListPage extends StatelessWidget {
  final List<Tache> tasks;

  TaskListPage({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.asset(
            tasks[index].image,
            width: 48.0,
            height: 48.0,
          ),
          title: Text(tasks[index].name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailsPage(task: tasks[index]),
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
          ],
        ),
      ),
    );
  }
}

class CultureEtape extends StatelessWidget {
  final List<Etape> etapes = [
    Etape(
      name: 'Étape 1 : Préparation du système',
      image: 'assets/images/systeme.png',
      description:
          'Mise en place du système d\'aquaponie, les bacs de culture et les composants de filtration.',
      tasks: [
        Tache(
            name:
                'Mettez le moteur en marge et Vérifier que l\'eau circule dans tout le système',
            image: 'assets/images/pepiniere.png'),
      ],
    ),
    Etape(
      name: 'Étape 2 : Germination des graines',
      image: 'assets/images/pepiniere.png',
      description: 'Description de l\'étape 2',
      tasks: [
        Tache(
            name: 'Sélectionner des variétés de tomates.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                'Préparer un milieu de germination approprié, tel que des cubes de laine de roche ou des pastilles de tourbe.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                'Semer les graines de tomates dans le milieu de germination et les maintenir dans des conditions de chaleur et d\'humidité optimales.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                ' Surveiller et arroser régulièrement les semis jusqu\'à ce qu\'ils émergent',
            image: 'assets/images/pepiniere.png'),
      ],
    ),
    Etape(
      name: 'Étape 2 : Repiquage des plants',
      image: 'assets/images/repiquage 1.png',
      description: 'Description de l\'étape 2',
      tasks: [
        Tache(
            name:
                'Lorsque les plants de tomates ont développé quelques feuilles, les transplanter dans des pots individuels remplis de substrat approprié.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                'Placer les pots dans le système d\'aquaponie, de préférence dans des bacs flottants ou des lits de culture.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                'Assurer une bonne circulation de l\'eau autour des racines des plants de tomates.',
            image: 'assets/images/pepiniere.png'),
      ],
    ),
    Etape(
      name: 'Étape 4 : Croissance et entretien des plants',
      image: 'assets/images/entretien_tomate.jpg',
      description: 'Description de l\'étape 2',
      tasks: [
        Tache(
            name:
                'Fournir un éclairage adéquat pour favoriser la croissance des plants de tomates, en utilisant des lampes artificielles si nécessaire.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                'Tailler les plants de tomates pour favoriser un bon développement et une bonne circulation de l\'air.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                'Attacher les tiges des plants à des supports pour les maintenir droits et stables.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                'Éliminer les feuilles et les branches mortes ou endommagées.',
            image: 'assets/images/entretien_tomate2.jpg'),
      ],
    ),
    Etape(
      name: 'Étape 5 : Pollinisation et fructification',
      image: 'assets/images/pollinisation.jpg',
      description: 'Description de l\'étape 2',
      tasks: [
        Tache(
            name:
                'Encourager la pollinisation des fleurs de tomates en secouant délicatement les plants ou en utilisant une brosse douce.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                'Fournir un soutien supplémentaire aux tiges chargées de fruits en utilisant des treillis ou des cages à tomates.',
            image: 'assets/images/pepiniere.png'),
      ],
    ),
    Etape(
      name: 'Étape 6 : Récolte et consommation',
      image: 'assets/images/recolte_tomate.jpg',
      description: 'Description de l\'étape 2',
      tasks: [
        Tache(
            name:
                'Récolter les tomates mûres lorsque leur couleur est uniforme et qu\'elles sont fermes au toucher.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                'Retirer les tomates du système d\'aquaponie avec précaution.',
            image: 'assets/images/pepiniere.png'),
        Tache(
            name:
                'Consommer les tomates fraîches ou les conserver selon vos préférences.',
            image: 'assets/images/pepiniere.png'),
      ],
    ),

    // Ajoutez plus d'étapes si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Étapes d\'évolution de la culture'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: etapes.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EtapeDetailsPage(etape: etapes[index]),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2.0,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              etapes[index].image,
                              width: double.infinity,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              etapes[index].name,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              etapes[index].description,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
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

class EtapeDetailsPage extends StatelessWidget {
  final Etape etape;

  EtapeDetailsPage({required this.etape});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(etape.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                etape.image,
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text(
                etape.name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                etape.description,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Tâches:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TaskListPage(tasks: etape.tasks),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CultureEtape(),
  ));
}
