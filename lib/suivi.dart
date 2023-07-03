import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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

class Etape {
  final String name;
  final String description;
  final String image;
  final List<Tache> tasks;

  Etape({
    required this.name,
    required this.description,
    required this.image,
    required this.tasks,
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
      physics: NeverScrollableScrollPhysics(),
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
              'Status: ${task.isCompleted ? 'Effectuée' : 'Non éffectuée'}',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class Suivi extends StatefulWidget {
  @override
  _SuiviState createState() => _SuiviState();
}

class _SuiviState extends State<Suivi> {
  DateTime? selectedDate;
  List<Etape> etapes = [
    Etape(
      name: 'Étape : Germination des graines',
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
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evolution des cultures'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  selectedDate != null
                      ? 'Date de début : ${selectedDate!.toString().substring(0, 10)}'
                      : 'Sélectionner une date',
                ),
              ),
              SizedBox(height: 16.0),
              if (selectedDate != null)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: etapes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 2.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EtapeDetailsPage(etape: etapes[index]),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              etapes[index].image,
                              width: double.infinity,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    etapes[index].name,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    etapes[index].description,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 8.0),
                                  TaskListPage(tasks: etapes[index].tasks),
                                ],
                              ),
                            ),
                          ],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              etape.image,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    etape.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    etape.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Tâches:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TaskListPage(tasks: etape.tasks),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Suivi(),
  ));
}
