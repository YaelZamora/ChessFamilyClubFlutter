import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuscarUsuarioPage extends StatefulWidget {
  const BuscarUsuarioPage({super.key});

  @override
  State<BuscarUsuarioPage> createState() => _BuscarUsuarioPageState();
}

class _BuscarUsuarioPageState extends State<BuscarUsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar usuario'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
      ),
      backgroundColor: const Color.fromRGBO(66, 66, 66, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white54,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Buscar',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white54,
                ),
                clipBehavior: Clip.hardEdge,
                child: MaterialButton(
                  onPressed: () {
                    Future getPartidas() async {
                      final url = Uri.https(
                        'https://lichess.org/api/games/user/YaelZamora',
                      );

                      final resp = await http.get(url);
                    }
                  },
                  child: const Text('Buscar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
