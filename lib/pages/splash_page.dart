import 'package:calculadora_imc/model/usuario_model.dart';
import 'package:calculadora_imc/pages/dados_cadastrai.dart';
import 'package:calculadora_imc/pages/home_screen.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_repository.dart';
import 'package:calculadora_imc/shared/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var usuarioIMCRepository = SQLiteRepository();
  var _usuario = <UsuarioModel>[];
  var nome = "";

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  obterIMC() async {
    _usuario = await usuarioIMCRepository.obterDadosUsuario();

    for (var element in _usuario) {
      nome = element.nome;
    }
    setState(() {});
  }

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
          Animate(
            onComplete: (controller) {
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(seconds: 3),
                  type: PageTransitionType.fade,
                  child: nome.isNotEmpty
                      ? const HomeScreen()
                      : const DadosCadastrais(),
                ),
              );
            },
            effects: const [
              FadeEffect(
                delay: Duration(seconds: 1),
                duration: Duration(seconds: 4),
              )
            ],
            child: Image.asset(
              'assets/images/imc.png',
              scale: 1.5,
              color: const Color.fromARGB(255, 3, 84, 160),
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
