import 'package:flutter/material.dart';
import '../model/usuario_model.dart';
import '../repository/sqlite/sqlite_database.dart';
import '../repository/sqlite/sqlite_repository.dart';
import '../shared/constants/custom_colors.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  var dadosIMCRepository = SQLiteRepository();
  SQLiteDatabase sql = SQLiteDatabase();
  var _usuario = <UsuarioModel>[];
  var pesoController = TextEditingController();
  var nomeController = TextEditingController();
  var metaController = TextEditingController();

  bool favorite = false;

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  obterIMC() async {
    _usuario = await dadosIMCRepository.obterDadosUsuario();

    setState(() {});
    debugPrint(_usuario.toString());
  }

  double _alturaEscolhida = 121;
  final List<bool> _sexo = <bool>[false, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromARGB(108, 158, 158, 158),
            ),
            margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 35),
            height: 650,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Card(
                    color: Colors.transparent,
                    elevation: 60,
                    child: Image.asset(
                      'assets/images/imc.png',
                      scale: 2.5,
                      color: const Color.fromARGB(255, 3, 84, 160),
                    ),
                  ),
                  const SizedBox(height: 55),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 3,
                    color: const Color.fromARGB(131, 255, 255, 255),
                    child: TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 16, 112, 190),
                        ),
                        labelText: "Nome",
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 4,
                    color: const Color.fromARGB(131, 255, 255, 255),
                    child: ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                          for (var i = 0; i < _sexo.length; i++) {
                            _sexo[i] = i == index;
                          }
                        });
                      },
                      isSelected: _sexo,
                      selectedBorderColor:
                          const Color.fromARGB(255, 16, 112, 190),
                      selectedColor: const Color.fromARGB(255, 16, 112, 190),
                      fillColor: Colors.green[200],
                      color: const Color.fromARGB(255, 138, 170, 227),
                      constraints: const BoxConstraints(
                        minHeight: 53.0,
                        minWidth: 139.5,
                      ),
                      children: const [
                        Text(
                          'Masculino',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Feminino',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 3,
                    color: const Color.fromARGB(131, 255, 255, 255),
                    child: Row(
                      children: [
                        Slider(
                          activeColor: const Color.fromARGB(255, 16, 112, 190),
                          value: _alturaEscolhida,
                          min: 120,
                          max: 250,
                          onChanged: (double altura) {
                            setState(() {
                              _alturaEscolhida = altura;
                            });
                          },
                        ),
                        Text(
                          "Altura: ${_alturaEscolhida.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 16, 112, 190),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 3,
                    color: const Color.fromARGB(131, 255, 255, 255),
                    child: TextField(
                      controller: metaController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 16, 112, 190),
                        ),
                        labelText: "Meta",
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 3,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CustomColors().getGradientMainColor(),
                            CustomColors().getGradientSecondaryColor(),
                          ],
                        ),
                      ),
                      width: 750,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "ENTRAR",
                          style: TextStyle(
                              color: Color.fromARGB(255, 16, 112, 190),
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
