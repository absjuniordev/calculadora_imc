import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:calculadora_imc/model/usuario_model.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_repository.dart';
import 'package:calculadora_imc/shared/constants/custom_colors.dart';
import 'package:flutter/material.dart';

const _texts = ['Bem Vindo!', 'Calculadora ', 'IMC'];

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TextEditingController controller = TextEditingController();
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
    debugPrint(_usuario.toString());
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
          Card(
            elevation: 25,
            color: Colors.transparent,
            child: AnimatedTextKit(
              totalRepeatCount: 1,
              onFinished: () {
                nome.isNotEmpty
                    ? Navigator.of(context).pushReplacementNamed('/home_screen')
                    : Navigator.of(context)
                        .pushReplacementNamed('/dados_cadastrais');
              },
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
