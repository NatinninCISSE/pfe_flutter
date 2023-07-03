import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(PageProfil());
}

class PageProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page de profil',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = 'CISSE';
  String aquaponicsDevice = 'Dispositif d’aquaponie';
  String profileImage = 'assets/images/profile.jpg';

  String newUsername = '';
  String newProfileImage = '';

  final TextEditingController usernameController = TextEditingController();
  final _imagePicker = ImagePicker();

  void showEditUsernameDialog() {
    usernameController.text = username;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier mon profil '),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                subtitle: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Pseudo',
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('photo'),
                onTap: () async {
                  final pickedImage =
                      await _imagePicker.getImage(source: ImageSource.camera);
                  setState(() {
                    if (pickedImage != null) {
                      profileImage = pickedImage.path;
                    }
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galerie'),
                onTap: () async {
                  final pickedImage =
                      await _imagePicker.getImage(source: ImageSource.gallery);
                  setState(() {
                    if (pickedImage != null) {
                      profileImage = pickedImage.path;
                    }
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  void showComplaintForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComplaintFormPage(),
      ),
    );
  }

  void showReclamationsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReclamationsPage(),
      ),
    );
  }

  void showChatbotPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatbotPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(profileImage),
                ),
                SizedBox(height: 16.0),
                Text(
                  '$username',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16.0),
                ListTile(
                  title: Text('Dispositif d’aquaponie'),
                  subtitle: Text(aquaponicsDevice),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditUsernameDialog();
        },
        child: Icon(Icons.edit),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Profil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Reclamation'),
              onTap: () {
                showReclamationsPage();
              },
            ),
            ListTile(
              title: Text('Chatbot'),
              onTap: () {
                showChatbotPage();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ComplaintFormPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController deviceController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void submitComplaint(BuildContext context) {
    final String name = nameController.text;
    final String device = deviceController.text;
    final String subject = subjectController.text;
    final String description = descriptionController.text;

    // Perform complaint submission logic here

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvelle reclamation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remplissez les renseignements ci-dessous :',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                labelText: 'Objet de la reclamation',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description du problème',
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                submitComplaint(context);
              },
              child: Text('Soumettre'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReclamationsPage extends StatefulWidget {
  @override
  _ReclamationsPageState createState() => _ReclamationsPageState();
}

class _ReclamationsPageState extends State<ReclamationsPage> {
  List<String> complaints = [
    'Panne du moteur',
    'Arret du système de filtration',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reclamations'),
      ),
      body: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (BuildContext context, int index) {
          final String complaint = complaints[index];
          return ListTile(
            title: Text(complaint),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ReclamationDetailsPage(complaint),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComplaintFormPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ReclamationDetailsPage extends StatelessWidget {
  final String complaint;

  ReclamationDetailsPage(this.complaint);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details de la reclamation'),
      ),
      body: Center(
        child: Text(
          'Reclamation: $complaint',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

class ChatbotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUserMessage: true,
        ),
      );
      _messages.add(
        ChatMessage(
          text: getChatbotResponse(text),
          isUserMessage: false,
        ),
      );
    });
  }

  String getChatbotResponse(String message) {
    message = message.toLowerCase();

    if (message.contains('bonjour')) {
      return 'Comment allez-vous ? Bonjour !';
    } else if (message.contains('et vous ?')) {
      return "Je vais super bien ! En quoi puis-je t'aider ?";
    } else if (message
        .contains('j\'ai un problème au niveau de mon dispositif')) {
      return 'Expliquez en quelques mots votre problème.';
    } else {
      // Send complaint form
      ComplaintFormPage();
      return "Je m’excuse, je n’ai pas compris. Je vous met immédiatement en contact avec un administrateur. Nous vous reviendrons très bientôt.";
    }

    // Throw an error as a fallback
    throw 'Invalid chatbot response';
  }

  Widget _buildMessageList() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              message.text,
              style: TextStyle(
                fontWeight:
                    message.isUserMessage ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            tileColor:
                message.isUserMessage ? Colors.green[100] : Colors.grey[100],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          Divider(height: 1.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Entrez votre message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({
    required this.text,
    required this.isUserMessage,
  });
}
