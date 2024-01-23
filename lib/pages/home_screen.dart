import 'dart:io';

import 'package:calculadora_imc/model/dados_imc.dart';
import 'package:calculadora_imc/components/home_floating_action_button.dart';
import 'package:calculadora_imc/model/usuario_model.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_repository.dart';
import 'package:calculadora_imc/shared/constants/custom_colors.dart';
import 'package:flutter/material.dart';

import '../components/imc_listagem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dadosIMCRepository = SQLiteRepository();
  var _imc = <DadosIMC>[];
  var _user = <UsuarioModel>[];
  var pesoController = TextEditingController();
  late String nomeUsuario = '';
  late double alturaUsuario = 0.0;
  late String photo = "";
  late String meta = "";

  @override
  void initState() {
    super.initState();
    obterIMC();
    obterUsuario();
  }

  obterIMC() async {
    _imc = await dadosIMCRepository.obterDadosIMC();
    setState(() {});
  }

  obterUsuario() async {
    _user = await dadosIMCRepository.obterDadosUsuario();
    nomeUsuario = _user.isNotEmpty ? _user[0].nome : '';
    alturaUsuario = _user.isNotEmpty ? _user[0].altura / 100.0 : 0.0;
    photo = _user[0].photo;
    meta = _user[0].meta;
    

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetFloatingActionButton(
        update: obterIMC(),
        peso: pesoController,
        altura: alturaUsuario,
        dadosIMCRepository: dadosIMCRepository,
      ),
      backgroundColor: CustomColors().getCircleColor(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "Calculadora IMC",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 29),
              child: Row(
                children: [
                  Card(
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 170,
                      width: 340,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: FileImage(
                                File(photo),
                              ),
                              radius: 55,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    nomeUsuario,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text("Altura:"),
                                      Text(
                                        "$alturaUsuario cm",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 160, 75, 75),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Sexo:"),
                                      Text(
                                        "$alturaUsuario",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 160, 75, 75),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Card(
                                    elevation: 3,
                                    child: Container(
                                      height: 65,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 214, 207, 186),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(meta.toString()),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Historico de IMC",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Realize avaliações periodicamente",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "Seus ultimos resultados",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Icon(
                        Icons.scale,
                        color: Colors.blue,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Saiba mais!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  IMCListagem(
                    imcList: _imc,
                    update: obterIMC(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
