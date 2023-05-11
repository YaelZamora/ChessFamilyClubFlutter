import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Puzzle {
  Puzzle({
    required this.game,
  });

  Game game;

  factory Puzzle.fromRawJson(String str) => Puzzle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Puzzle.fromJson(Map<String, dynamic> json) => Puzzle(
        game: Game.fromJson(json["game"]),
      );

  Map<String, dynamic> toJson() => {
        "game": game.toJson(),
      };
}

class Game {
  Game({
    required this.id,
    required this.pgn,
  });

  String id;
  String pgn;

  factory Game.fromRawJson(String str) => Game.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["game"]["id"],
        pgn: json["game"]["pgn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pgn": pgn,
      };
}

Future<Puzzle> fetchGame() async {
  final response = await http.get(
    Uri.parse('https://lichess.org/api/puzzle/daily'),
  );
  //final url = Uri.https('https://lichess.org/api/puzzle/daily', 'game');
  //final response = await http.get(url);

  if (response.statusCode == 200) {
    final puzzle = Puzzle.fromJson(jsonDecode(response.body));
    return puzzle;
  } else {
    throw Exception('Valió verdura');
  }
}

class PGNPrueba extends StatefulWidget {
  const PGNPrueba({super.key});

  @override
  State<PGNPrueba> createState() => _PGNPruebaState();
}

class _PGNPruebaState extends State<PGNPrueba> {
  late Future<Puzzle> futureGame;

  @override
  void initState() {
    super.initState();
    futureGame = fetchGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: futureGame,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.pgn);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
