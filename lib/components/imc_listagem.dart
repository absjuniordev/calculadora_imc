import 'package:calculadora_imc/model/dados_imc.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_repository.dart';
import 'package:calculadora_imc/shared/constants/colors_card.dart';
import 'package:calculadora_imc/utils/verificacao.dart';
import 'package:flutter/material.dart';

class IMCListagem extends StatefulWidget {
  final List<DadosIMC> imcList;
  final Future update;
  final dadosIMCRepository = SQLiteRepository();

  IMCListagem({
    Key? key,
    required this.imcList,
    required this.update,
  }) : super(key: key);

  @override
  State<IMCListagem> createState() => _IMCListagemState();
}

class _IMCListagemState extends State<IMCListagem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 410,
      child: ListView.builder(
        itemCount: widget.imcList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var imc = widget.imcList[index];
          return Dismissible(
            key: Key(imc.id.toString()),
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.startToEnd) {
                return await showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      title: const Text("Delete"),
                      content: const Text(
                        "Você tem certeza que deseja deletar esse Card?",
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);

                            await widget.dadosIMCRepository.removerIMC(imc.id);
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
                            Navigator.of(context).pop(false);
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
            onDismissed: (DismissDirection dismissDirection) async {
              await widget.dadosIMCRepository.removerIMC(imc.id);

              await widget.update;
            },
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Item: ${verificacao(imc.result)} ",
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
    );
  }
}
