import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:calculadora_imc/shared/constants/custom_colors.dart';
import 'package:flutter/material.dart';

const _texts = ['Bem Vindo!', 'Calculadora ', 'IMC'];

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/home_screen');
    });
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomColors().getGradientMainColor(),
            CustomColors().getGradientSecondaryColor(),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Card(
            elevation: 25,
            color: Colors.transparent,
            child: AnimatedTextKit(
              animatedTexts: [
                for (final text in _texts)
                  TypewriterAnimatedText(
                    text,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.start,
                  )
              ],
            ),
          ),
          const Spacer(flex: 1),
          const Card(
            elevation: 100,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "By Arnaldo Junior",
                style: TextStyle(fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
