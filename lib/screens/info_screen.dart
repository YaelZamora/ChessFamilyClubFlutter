import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(66, 66, 66, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.33,
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(
                  'assets/chess-white.png',
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: size.width,
            height: size.height * 0.55,
            child: SingleChildScrollView(
              child: (index == 0)
                  ? const QuienesSomos()
                  : (index == 1)
                      ? const NuestraHistoria()
                      : (index == 2)
                          ? TextButton(
                              onPressed: () {},
                              child: const Text('Equipo en Lichess'),
                            )
                          : const AcercaDeChessFamily(),
            ),
          ),
        ],
      ),
    );
  }
}

class QuienesSomos extends StatelessWidget {
  const QuienesSomos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¿Quiénes somos?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        Text(
          'Chess Family Club es un club de ajedrez dedicado a la difusión de este bello deporte principalmente en el Estado de México y el estado de Aguascalientes.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w100,
          ),
        )
      ],
    );
  }
}

class NuestraHistoria extends StatelessWidget {
  const NuestraHistoria({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nuestra Historia',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        Text(
          'Chess Family Club se formó en el año de 2019, cuando nuestro amigo José Luis Salas Zamora, estaba conviviendo con un amigo suyo y entre pláticas y risas, comenzó a surgir la idea de un club que se dedicará a difundir el deporte por todo el país.\nComenzó siendo una página de memes para que después comenzarán a hacer un podcast en línea y finalmente, se decidieron por comenzar las transmisiones de torneos, el resto es historia.\nChess Family Club estuvo en el parque Naucalli ofreciendo clases gratuitas a todas las edades y posteriormente, en pandemia, ofrecieron clases virtuales. Actualmente, José Luis, Iván, Sofía y Yael llevan el proyecto de Chess Family llevando transmisiones, entrevistas y memes a cientos de seguidores en redes sociales.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w100,
          ),
        )
      ],
    );
  }
}

class AcercaDeChessFamily extends StatelessWidget {
  const AcercaDeChessFamily({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acerca de Chess Family',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        Text(
          'Chess Family Club pretende difundir el ajedrez por todo México, mostrando que es un deporte muy divertido del cual puedes hacer cientos de amigos por todo el mundo.\nActualmente el club se encuentra dando clases en línea y organizando muchas actividades con sus usuarios regalando diversos premios. Todo eso buscando fomentar la sana convivencia y atraer a más gente a este deporte en ascenso.\nActualmente, Chess Family se encuentra en proceso para convertirse en un club de ajedrez oficial y reconocido ante la FENAMAC.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w100,
          ),
        )
      ],
    );
  }
}
