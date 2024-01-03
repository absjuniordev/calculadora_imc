import 'package:calculadora_imc/model/dados_imc.dart';
import 'package:calculadora_imc/components/home_floating_action_button.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_repository.dart';
import 'package:calculadora_imc/shared/constants/colors_card.dart';
import 'package:calculadora_imc/shared/constants/custom_colors.dart';
import 'package:calculadora_imc/utils/verificacao.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dadosIMCRepository = SQLiteRepository();
  var _imc = <DadosIMC>[];
  var pesoController = TextEditingController();
  bool favorite = false;
 late double altura;

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  obterIMC() async {
    _imc = await dadosIMCRepository.obterDadosIMC();
      
    setState(() {});
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetFloatingActionButton(
        update: obterIMC(),
        peso: pesoController,
       
        dadosIMCRepository: dadosIMCRepository,
        
      ),
      backgroundColor: CustomColors().getGradientMainColor(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                 
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CircleAvatar(
                          radius: 35,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${_imc}" ,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${_imc.map((e) => e.altura)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 160, 75, 75),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xFF9F97E2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xFF9F97E2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
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
                  SizedBox(
                    height: 450,
                    child: ListView.builder(
                      itemCount: _imc.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var imc = _imc[index];
                        return Dismissible(
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext bc) {
                                  return AlertDialog(
                                    title: const Text("Delete"),
                                    content: const Text(
                                      "Você tem certeza que deseja deletar esse Card ?",
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("Sim"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text("Não"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext bc) {
                                  return AlertDialog(
                                    title: const Text("Salvar"),
                                    content: const Text(
                                      "Deseja favoritar este Card?",
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            imc.isFavorite = true;
                                            // dadosIMCRepository.atualizar(
                                            //     imc.id, imc.isFavorite);
                                          });
                                          Navigator.of(context).pop(false);
                                          favorite = false;
                                        },
                                        child: const Text("Sim"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text("Não"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          background: Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.delete,
                              ),
                            ),
                          ),
                          secondaryBackground: Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            color: Colors.green,
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.check,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          onDismissed:
                              (DismissDirection dismissDirection) async {
                            await dadosIMCRepository.removerIMC(imc.id);
                            obterIMC();
                          },
                          key: Key(imc.id.toString()),
                          child: Card(
                            color: determinarCor(imc.result),
                            elevation: 50,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${verificacao(imc.result)} ",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Calculo em: ${imc.dateTime}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
