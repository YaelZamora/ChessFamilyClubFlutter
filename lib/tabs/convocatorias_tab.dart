import 'package:card_swiper/card_swiper.dart';
import 'package:chess_family_club/models/convocatoria_model.dart';
import 'package:chess_family_club/screens/convocatoria_screen.dart';
import 'package:chess_family_club/services/convocatoria_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConvocatoriasTab extends StatelessWidget {
  const ConvocatoriasTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final convocatoriasService = Provider.of<ConvocatoriaService>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width,
            height: 20,
          ),
          const Text(
            'Convocatorias',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            child: Swiper(
              itemWidth: 300,
              itemHeight: 400,
              itemCount: convocatoriasService.convocatoria.length,
              itemBuilder: (context, index) => Image(
                image:
                    NetworkImage('https://picsum.photos/id/${index + 20}/400'),
                fit: BoxFit.cover,
              ),
              onTap: (index) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ConvocatoriaScreen(
                    convocatoria: convocatoriasService.convocatoria[index],
                  ),
                ),
              ),
              pagination: const SwiperPagination(),
              control: const SwiperControl(),
            ),
          ),
          const Text(
            'Enlaces de registro',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            width: size.width,
            height: size.height * 0.4,
            child: ListView.separated(
              itemCount: convocatoriasService.convocatoria.length,
              itemBuilder: (BuildContext context, int index) => Enlaces(
                convocatoria: convocatoriasService.convocatoria[index],
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const Padding(
                padding: EdgeInsets.only(top: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Enlaces extends StatelessWidget {
  const Enlaces({
    super.key,
    required this.convocatoria,
  });

  final Convocatoria convocatoria;

  @override
  Widget build(BuildContext context) {
    return Text(
      convocatoria.link,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
    );
  }
}
