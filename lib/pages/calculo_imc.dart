import 'package:calculadora_imc/model/dados_imc.dart';
import 'package:calculadora_imc/pages/homes/home_appBar.dart';
import 'package:calculadora_imc/repository/dados_imc_repositoty.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_database.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_repository.dart';
import 'package:calculadora_imc/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../utils/colors_card.dart';
import '../utils/verificacao.dart';

class CalculoIMCPage extends StatefulWidget {
  const CalculoIMCPage({super.key});

  @override
  State<CalculoIMCPage> createState() => _CalculoIMCPageState();
}

class _CalculoIMCPageState extends State<CalculoIMCPage> {
  var dadosIMCRepository = SQLiteRepository();
  SQLiteDatabase sql = SQLiteDatabase();
  var _imc = <DadosIMC>[];
  var pesoController = TextEditingController();
  var nomeController = TextEditingController();
  var alturaController = TextEditingController();

  bool favorite = false;

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  obterIMC() async {
    _imc = await dadosIMCRepository.obterDados();
    for (var element in _imc) {
      nomeController.text = element.nome;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 67, 221, 36),
          onPressed: () {
            pesoController.clear();
            alturaController.clear();
            nomeController.clear();

            showDialog(
              useSafeArea: true,
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title:
                      const Text("Calcular IMC", textAlign: TextAlign.center),
                  content: SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          controller: nomeController,
                          hintText: "Ex: João",
                          labelText: "Nome",
                          maxLengh: 25,
                          width: 250,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 80,
                              child: CustomTextField(
                                controller: pesoController,
                                hintText: "Ex:85",
                                labelText: "Peso",
                                maxLengh: 3,
                                width: 80,
                              ),
                            ),
                            const SizedBox(width: 30),
                            SizedBox(
                              width: 80,
                              child: CustomTextField(
                                controller: alturaController,
                                hintText: "Ex:1.85",
                                labelText: "Altura",
                                maxLengh: 4,
                                width: 80,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () async {
                        var result = DadosIMCRepository.calculoIMC(
                            double.parse(alturaController.text),
                            double.parse(pesoController.text));

                        await dadosIMCRepository.salvar(
                          DadosIMC(
                              0,
                              nomeController.text,
                              double.parse(pesoController.text),
                              double.parse(alturaController.text),
                              result),
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        obterIMC();
                        setState(() {});
                      },
                      child: const Text("Salvar"),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        appBar: getHomeAppBar(nomeController.text),
        body: ListView.builder(
          itemCount: _imc.length,
          itemBuilder: (BuildContext bc, int index) {
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
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Sim"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
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
                            onPressed: () => Navigator.of(context).pop(false),
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
                margin: const EdgeInsets.only(top: 10),
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete,
                  ),
                ),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 10),
                color: Colors.green,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check,
                    color: Colors.amber,
                  ),
                ),
              ),
              onDismissed: (DismissDirection dismissDirection) async {
                await dadosIMCRepository.remover(imc.id);
                obterIMC();
              },
              key: Key(imc.id.toString()),
              child: Card(
                key: Key(imc.id.toString()),
                elevation: 5,
                color: determinarCor(imc.result),
                child: ListTile(
                  leading: imc.isFavorite
                      ? const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 30,
                        )
                      : null,
                  title: Row(
                    children: [
                      Text(
                        "${verificacao(imc.result)} ",
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            imc.dateTime,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
