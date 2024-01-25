import 'dart:io';
import 'package:calculadora_imc/model/usuario_model.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_repository.dart';
import 'package:flutter/material.dart';
import '../components/itens_navegacao.dart';
import '../shared/constants/custom_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dadosIMCRepository = SQLiteRepository();
  var _user = <UsuarioModel>[];

  late String nomeUsuario = '';
  late double alturaUsuario = 0.0;
  late String photo = "";
  late String meta = "";
  late String sexo = "";

  @override
  void initState() {
    super.initState();
    obterUsuario();
  }

  obterUsuario() async {
    _user = await dadosIMCRepository.obterDadosUsuario();
    nomeUsuario = _user.isNotEmpty ? _user[0].nome : '';
    alturaUsuario = _user.isNotEmpty ? _user[0].altura / 100.0 : 0.0;
    photo = _user[0].photo;
    meta = _user[0].meta;
    sexo = _user[0].sexo;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().getCircleColor(),
      body: Column(
        children: [
          const SizedBox(height: 55),
          ListTile(
            title: const Text(
              "Calculadora IMC",
              style: TextStyle(fontSize: 22),
            ),
            trailing: InkWell(
              onTap: () {},
              child: const Icon(Icons.notifications, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Card(
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Card(
                        shadowColor: const Color.fromARGB(255, 8, 189, 105),
                        shape: const CircleBorder(),
                        elevation: 5,
                        child: CircleAvatar(
                          backgroundImage: FileImage(
                            File(photo),
                          ),
                          radius: 55,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              nomeUsuario,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                const Text("Altura: "),
                                Text(
                                  "$alturaUsuario cm",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 160, 75, 75),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Sexo: "),
                                Text(
                                  sexo,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 160, 75, 75),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 65,
                              width: 180,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: const Color.fromARGB(255, 214, 207, 186),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text(meta),
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
          ),
          const SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height / 1.69,
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Historico de IMC",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Realize avaliações periodicamente",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 50),
                ItensNavegacao(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
