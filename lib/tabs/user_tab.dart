import 'package:chess_family_club/screens/login_screen.dart';
import 'package:chess_family_club/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context, listen: false);
    Map<String, String> miembro = {
      'Usuario': authService.correo,
      'ID FIDE': 'N/A',
      'ELO FIDE': 'N/A',
      'ID FENAMAC': 'N/A',
      'ELO FENAMAC': 'N/A',
      'FED': 'MEX',
      'Usuario Lichess': 'No disponible',
      'Mejor Puntuación': 'N/A',
    };

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const CircleAvatar(
            radius: 60,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: size.width,
            height: size.height * 0.5,
            child: ListView.separated(
              itemCount: miembro.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                leading: const SizedBox(width: 40),
                title: Text(
                  authService.correo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  miembro.values.elementAt(index),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                indent: 50,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: size.width,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            clipBehavior: Clip.hardEdge,
            child: MaterialButton(
              minWidth: size.width,
              height: 50,
              onPressed: () {
                authService.logout();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: const Text(
                'CERRAR SESIÓN',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  wordSpacing: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
