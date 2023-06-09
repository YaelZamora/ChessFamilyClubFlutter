import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Segun yo, para producción, esto va en services
Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Valió verdura');
  }
}

//Esto debe de ir en models, y lo podemos sacar de quicktype.io
class Album {
  final int userId;
  final int id;

  const Album({
    required this.userId,
    required this.id,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
    );
  }
}

class PaginaPrueba extends StatefulWidget {
  const PaginaPrueba({super.key});

  @override
  State<PaginaPrueba> createState() => _PaginaPruebaState();
}

class _PaginaPruebaState extends State<PaginaPrueba> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: futureAlbum,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.pgn);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
