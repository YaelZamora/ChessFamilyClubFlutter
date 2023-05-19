import 'package:chess_family_club/screens/check_auth_screen.dart';
import 'package:chess_family_club/services/notifications_service.dart';
import 'package:chess_family_club/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ConvocatoriaService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const CheckAuthScreen(),
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}
