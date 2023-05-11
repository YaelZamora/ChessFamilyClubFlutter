import 'package:chess_family_club/models/convocatoria_model.dart';
import 'package:chess_family_club/screens/nueva_convocatoria_screen.dart';
import 'package:flutter/material.dart';

class ConvocatoriaScreen extends StatelessWidget {
  const ConvocatoriaScreen({
    super.key,
    required this.convocatoria,
  });

  final Convocatoria convocatoria;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          convocatoria.lugar,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Convocatoria',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                convocatoria.fecha,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                convocatoria.lugar,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              convocatoria.info,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: size.width,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://picsum.photos/id/43/500',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => NuevaConvocatoriaScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
