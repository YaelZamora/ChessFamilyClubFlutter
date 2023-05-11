import 'package:chess_family_club/providers/login_form_provider.dart';
import 'package:chess_family_club/screens/home_screen.dart';
import 'package:chess_family_club/screens/register_screen.dart';
import 'package:chess_family_club/services/auth_service.dart';
import 'package:chess_family_club/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(66, 66, 66, 1),
                  Color.fromRGBO(22, 22, 22, 1),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(255, 255, 255, 0.2),
                border: Border.all(
                  color: Colors.white,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    blurStyle: BlurStyle.inner,
                    blurRadius: 90,
                  ),
                ],
              ),
              child: ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: LoginFormWidget(),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 100,
            right: 100,
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const RegisterScreen(),
                ),
              ),
              child: const Text(
                'Registrarse',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -75,
          left: 75,
          right: 75,
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(
                  'assets/chess-white.png',
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 80,
          left: 25,
          child: Form(
            key: loginForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Correo',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => loginForm.email = value,
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = RegExp(pattern);

                      return regExp.hasMatch(value ?? '')
                          ? null
                          : 'El valor ingresado no luce como un correo';
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.only(left: 10),
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                    ),
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Contraseña',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => loginForm.password = value,
                    validator: (value) {
                      return (value != null && value.length >= 6)
                          ? null
                          : 'La contraseña debe de ser de 6 caracteres';
                    },
                  ),
                ),
                const SizedBox(height: 45),
                Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: MaterialButton(
                    minWidth: 250,
                    height: 50,
                    onPressed: loginForm.isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            final authService = Provider.of<AuthService>(
                                context,
                                listen: false);

                            if (!loginForm.isValidForm()) return;

                            loginForm.isLoading = true;

                            final String? errorMessage = await authService
                                .login(loginForm.email, loginForm.password);

                            if (errorMessage == null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                              );
                            } else {
                              NotificationsService.showSnackBar(errorMessage);
                            }

                            loginForm.isLoading = false;
                          },
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
