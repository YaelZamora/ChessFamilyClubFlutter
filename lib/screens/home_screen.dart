import 'package:chess_family_club/screens/info_screen.dart';
import 'package:chess_family_club/screens/login_screen.dart';
import 'package:chess_family_club/services/auth_service.dart';
import 'package:chess_family_club/services/convocatoria_service.dart';
import 'package:chess_family_club/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> index = [
    HomeTab(),
    //const VODTab(),
    //const ConvocatoriasTab(),
    const UserTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final convocatoriaService = Provider.of<ConvocatoriaService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    const snackBar = SnackBar(content: Text('Esperalo muy pronto'));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(66, 66, 66, 1),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 450,
              width: 250,
              child: ListView.separated(
                itemCount: drawerOpt.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text(
                    drawerOpt.elementAt(index),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InfoScreen(index: index),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
            const Spacer(),
            MaterialButton(
              minWidth: 250,
              height: 50,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text(
                'AFÍLIATE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
        title: const Text(
          'Chess Family Club',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authService.logout();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: index[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          //BottomNavigationBarItem(
          //  icon: Icon(Icons.video_collection_outlined),
          //  label: '',
          //),
          //BottomNavigationBarItem(
          //  icon: Icon(Icons.menu_book_sharp),
          //  label: '',
          //),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: '',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        //onPressed: () {
        //  convocatoriaService.selectedConvocatoria = Convocatoria(
        //    fecha: '',
        //    imagen: '',
        //    info: '',
        //    link: '',
        //    lugar: '',
        //    nombre: '',
        //  );
        //  (_currentIndex == 2)
        //      ? Navigator.push(
        //          context,
        //          MaterialPageRoute(
        //              builder: (BuildContext context) =>
        //                  NuevaConvocatoriaScreen()),
        //        )
        //      : Navigator.push(
        //          context,
        //          MaterialPageRoute(
        //            builder: (BuildContext context) => const AfiliacionScreen(),
        //          ),
        //        );
        //},
        tooltip: (_currentIndex == 2) ? 'Subir convocatoria' : 'Afíliate aquí',
        child: Icon(
          (_currentIndex == 2) ? Icons.add : Icons.edit_note,
        ),
      ),
    );
  }
}

List<String> drawerOpt = [
  '¿Quiénes somos?',
  'Nuestra historia',
  'Equipo en Lichess',
  'Acerca de Chess Family',
];
