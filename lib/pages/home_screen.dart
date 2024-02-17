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
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CustomColors().getGradientMainColor(),
                CustomColors().getGradientSecondaryColor()
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: const GradientRotation(9),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 20),
                child: ListTile(
                  title: Text(
                    "Calculadora IMC",
                    style: TextStyle(
                      fontSize: size.height / 29,
                      color: Colors.white,
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: size.height / 29,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height / 70,
                  horizontal: size.height / 50,
                ),
                child: Card(
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.height),
                      color: const Color.fromARGB(255, 240, 234, 234),
                    ),
                    height: size.height / 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
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
                              radius: size.height / 12,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    nomeUsuario,
                                    style: TextStyle(
                                      fontSize: size.height * .04,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Altura: ",
                                        style: TextStyle(
                                          fontSize: size.height * .020,
                                        ),
                                      ),
                                      Text(
                                        "$alturaUsuario cm",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 160, 75, 75),
                                          fontSize: size.height * .020,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Sexo: ",
                                        style: TextStyle(
                                          fontSize: size.height * .020,
                                        ),
                                      ),
                                      Text(
                                        sexo,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 160, 75, 75),
                                          fontSize: size.height * .020,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    height: size.height / 11.8,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: const Color.fromARGB(
                                          255, 214, 207, 186),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        meta,
                                        style: TextStyle(
                                          fontSize: size.width / 27,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * .018),
              Expanded(
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 234, 234),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .04,
                      ),
                      const SizedBox(height: 1),
                      Text(
                        "Realize avaliações periodicamente",
                        style: TextStyle(
                          fontSize: size.height / 40,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: size.height / 20,
                      ),
                      const ItensNavegacao(),
                    ],
                  ),
                ),
              )
            ],
          ),
          //
        ),
      ),
    );
  }
}
