import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_aisa/api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/painting.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() {
  runApp(AquaponicsForumApp());
}


class Post {
  final String username;
  final String date;

  final int id;
  final String image;
  final String contenu;
  final List<String> attachments;
  List<String> likes;
  List<Comment> comments;

  Post({
    required this.username,
    required this.date,
    required this.id,
    required this.image,
    required this.contenu,
    required this.attachments,
    List<String>? likes,
    List<Comment>? comments,
  })  : likes = likes ?? [],
        comments = comments ?? [];

  void like() {
    if (!likes.contains('Moi')) {
      likes.add('Moi');
    }
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      
      id: json['id'],
      username: json['username'],
      date: json['date'],
      image: json['image_poste'],
      contenu: json['contenu_poste'],
      attachments: List<String>.from(json['attachments']),
      likes: List<String>.from(json['likes']),
      comments: List<Comment>.from(
          json['comments'].map((commentJson) => Comment.fromJson(commentJson))),
    );
  }
}

class AquaponicsForumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aquaponics Forum',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ForumPage(),
    );
  }
}

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<Post> posts = [];

  late List<Widget> postsWidget = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  String baseUrl = 'http://192.168.1.128:8000/api/liste-poste';

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          List<dynamic> data = jsonDecode(response.body);
          setState(() {
            posts = data
                .map((json) {
                  // Récupérer le nom de l'image du produit
                  String imageName = json['image_poste'];

                  // Construire l'URL complète de l'image
                  String imageUrl = '$imageName';

                  return Post(
                    id: json['id'],
                    image: imageUrl,
                    contenu: json['contenu_poste'],
                    attachments: [],
                    date: json['created_at'],
                    username: '',
                  );
                })
                .cast<Post>()
                .toList();
            print('posts');
          });
        } else {
          print('La réponse du serveur est vide.');
        }
      } else {
        print(
            'Erreur lors de la récupération des posts (${response.statusCode}): ${response.body}');
      }
    } catch (error) {
      print('Erreur lors de la récupération des posts: $error');
    }

    setState(() {
      postsWidget = posts
          .map((post) => PostWidget(
                post: post,
                onLike: () => likePost(post),
                onComment: (comment) => addComment(post, comment),
                onLikesPressed: () => showLikesDialog(post.likes),
                onCommentsPressed: () => showCommentsDialog(post.comments),
              ))
          .toList();
    });
  }

  void addPost(Post post) {
    setState(() {
      posts.add(post);
    });
  }

  void likePost(Post post) {
    setState(() {
      post.like();
    });
  }

  void addComment(Post post, Comment comment) {
    setState(() {
      post.comments = List.from(post.comments)..add(comment);
    });
  }

  void showLikesDialog(List<String> likes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LikesDialog(likes);
      },
    );
  }

  void showCommentsDialog(List<Comment> comments) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommentsDialog(comments);
      },
    );
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aquaponics Forum'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PostDialog(addPost: addPost, pickImage: pickImage);
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return postsWidget[index];
        },
      ),
    );
  }
}


class Comment {
  final String username;
  final String date;
  final String text;

  Comment({
    required this.username,
    required this.date,
    required this.text,
  });

  static fromJson(commentJson) {}
}

class PostWidget extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final ValueChanged<Comment> onComment;
  final VoidCallback onLikesPressed;
  final VoidCallback onCommentsPressed;

  PostWidget({
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onLikesPressed,
    required this.onCommentsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // children: [
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           post.username,
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         Text(
        //           post.date,
        //           style: TextStyle(
        //             color: Colors.grey,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Text(post.contenu),
        //   ),
        //   if (post.image.isNotEmpty)
        //     Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: Wrap(
        //         spacing: 8.0,
        //         runSpacing: 4.0,
        //         children: [
        //           Container(
        //             width: 80.0,
        //             height: 80.0,
        //             child: Image.network(
        //           'http://192.168.1.128:8000/' + post.image,
        //         ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 8.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           children: [
        //             IconButton(
        //               onPressed: onLike,
        //               icon: Icon(Icons.thumb_up),
        //             ),
        //             GestureDetector(
        //               onTap: onLikesPressed,
        //               child: Text('${post.likes.length} Likes'),
        //             ),
        //           ],
        //         ),
        //         Row(
        //           children: [
        //             IconButton(
        //               onPressed: () {
        //                 showDialog(
        //                   context: context,
        //                   builder: (BuildContext context) {
        //                     return CommentDialog(onComment: onComment);
        //                   },
        //                 );
        //               },
        //               icon: Icon(Icons.comment),
        //             ),
        //             GestureDetector(
        //               onTap: onCommentsPressed,
        //               child: Text('${post.comments.length} Commentaires'),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }
}

class PostDialog extends StatefulWidget {
  final Function(Post) addPost;
  final Future<File?> Function() pickImage;

  PostDialog({required this.addPost, required this.pickImage});

  @override
  _PostDialogState createState() => _PostDialogState();
}

class _PostDialogState extends State<PostDialog> {
  TextEditingController textEditingController = TextEditingController();
  List<String> attachments = [];
  var file;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nouveau post'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Message',
              ),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            if (attachments.isNotEmpty)
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: attachments.map((attachment) {
                  return Container(
                    width: 80.0,
                    height: 80.0,
                    child: Image.file(File(attachment)),
                  );
                }).toList(),
              ),
            ElevatedButton(
              onPressed: () async {
                final pickedImage = await widget.pickImage();
                file = pickedImage;
                if (pickedImage != null) {
                  setState(() {
                    attachments.add(pickedImage.path);
                  });
                }
              },
              child: Text('Image'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Poster'),
          onPressed: () {
            // final post = Post(
            //   username: 'Moi',
            //   date: DateTime.now().toString(),
            //   text: textEditingController.text,
            //   attachments: attachments,
            // );
            // widget.addPost(post);

            var api = Api();

            api.uploadFile(file, textEditingController.text, '');

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class CommentDialog extends StatefulWidget {
  final ValueChanged<Comment> onComment;

  CommentDialog({required this.onComment});

  @override
  _CommentDialogState createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Comment'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Comment',
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Comment'),
          onPressed: () {
            final comment = Comment(
              username: 'Moi',
              date: DateTime.now().toString(),
              text: textEditingController.text,
            );
            widget.onComment(comment);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class LikesDialog extends StatelessWidget {
  final List<String> likes;

  LikesDialog(this.likes);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Likes'),
      content: SingleChildScrollView(
        child: ListBody(
          children: likes.map((like) {
            return Text(like);
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class CommentsDialog extends StatelessWidget {
  final List<Comment> comments;

  CommentsDialog(this.comments);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Comments'),
      content: SingleChildScrollView(
        child: ListBody(
          children: comments.map((comment) {
            return ListTile(
              title: Text(comment.username),
              subtitle: Text(comment.text),
              trailing: Text(comment.date),
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
