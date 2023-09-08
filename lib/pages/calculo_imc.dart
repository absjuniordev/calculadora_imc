import 'package:calculadora_imc/model/dados_imc.dart';
import 'package:calculadora_imc/repository/dados_imc_repositoty.dart';
import 'package:flutter/material.dart';

import '../utils/colors_card.dart';
import '../utils/verificacao.dart';

class CalculoIMCPage extends StatefulWidget {
  const CalculoIMCPage({super.key});

  @override
  State<CalculoIMCPage> createState() => _CalculoIMCPageState();
}

class _CalculoIMCPageState extends State<CalculoIMCPage> {
  var dadosIMCRepository = DadosIMCRepository();
  var _imc = <DadosIMC>[];
  var pesoController = TextEditingController();
  var nomeController = TextEditingController();
  var alturaController = TextEditingController();
  var peso = 0.0;
  var altura = 0.0;
  var result = 0.0;

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  obterIMC() async {
    _imc = await dadosIMCRepository.listasIMC();
    setState(() {});
  }

  double calculoIMC(double altura, double peso) {
    result = peso / (altura * altura);
    setState(() {});
    return result;
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
                    width: 90,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nomeController,
                          textAlign: TextAlign.start,
                          maxLength: 25,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            labelText: "Nome",
                            hintText: "Ex: João",
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 80,
                              child: TextField(
                                controller: pesoController,
                                textAlign: TextAlign.start,
                                maxLength: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  labelText: "Peso",
                                  hintText: "Ex:85",
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            SizedBox(
                              width: 80,
                              child: TextField(
                                controller: alturaController,
                                maxLength: 4,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  labelText: "Altura",
                                  hintText: "Ex:1.80",
                                ),
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
                        peso = double.parse(pesoController.text);
                        altura = double.parse(alturaController.text);
                        result = calculoIMC(altura, peso);

                        await dadosIMCRepository.addIMC(
                          DadosIMC(nomeController.text, peso, altura, result),
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Calculo IMC"),
        ),
        body: ListView.builder(
          itemCount: _imc.length,
          itemBuilder: (BuildContext bc, int index) {
            var imc = _imc[index];
            return Dismissible(
              background: Container(
                color: const Color.fromARGB(255, 11, 223, 75),
                child: const Icon(Icons.check),
              ),
              secondaryBackground: Container(
                color: const Color.fromARGB(255, 228, 19, 5),
                child: const Icon(Icons.cancel),
              ),
              onDismissed: (DismissDirection dismissDirection) async {
                await dadosIMCRepository.removeItem(imc.id);
                obterIMC();
              },
              key: Key(imc.id),
              child: Card(
                key: Key(imc.id),
                elevation: 5,
                color: determinarCor(imc.result),
                child: ListTile(
                  title: Text(
                    "${imc.nome} : ${verificacao(imc.result)} ",
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
