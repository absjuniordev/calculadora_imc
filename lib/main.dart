import 'package:calculadora_imc/pages/dados_cadastrai.dart';
import 'package:calculadora_imc/pages/home_screen.dart';
import 'package:calculadora_imc/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculadora de IMC",
      routes: {
        '/dados_cadastrais': (context) => const DadosCadastrais(),
        '/home_screen': (context) => const HomeScreen(),
        '/splash': (context) => const SplashPage(),
      },
      initialRoute: '/splash',
    );
  }
}
