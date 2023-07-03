import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class Api {
  static const String baseUrl = 'http://192.168.1.128:8000/api';
  static const String basePublic = 'http://192.168.1.128:8000/';

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    return json.decode(response.body);
  }

  path() {
    return basePublic;
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return json.decode(response.body);
  }

  Future<void> uploadFile(File file, String field1, String field2) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://192.168.1.128:8000/api/creer-poste'), // Replace with your upload endpoint
    );

    // Add file to the request
    request.files
        .add(await http.MultipartFile.fromPath('image_poste', file.path));

    // Add string fields to the request
    request.fields['contenu_poste'] = field1;
    // request.fields['field2'] = field2;

    var response = await request.send();

    print(response);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print('File upload failed');
    }
  }
}
