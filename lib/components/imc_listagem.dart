import 'package:calculadora_imc/model/dados_imc.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_repository.dart';
import 'package:calculadora_imc/shared/constants/colors_card.dart';
import 'package:calculadora_imc/utils/custom_show_dialgo.dart';
import 'package:calculadora_imc/utils/verificacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    widget.imcList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return SizedBox(
      height: 410,
      child: ListView.builder(
        itemCount: widget.imcList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var imc = widget.imcList[index];
          String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(
            DateTime.parse(imc.dateTime),
          );
          return Dismissible(
            key: Key(imc.id.toString()),
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.startToEnd) {
                return await customShowDialog(
                  delete: true,
                  title: "Deletar",
                  content: "Deseja realmente deletar este card?",
                  context: context,
                  dadosIMCRepository: widget.dadosIMCRepository,
                  id: imc.id,
                );
              } else if (direction == DismissDirection.endToStart) {
                return await customShowDialog(
                  delete: false,
                  title: "Favoritar",
                  content: "Deseja favoritar este card?",
                  context: context,
                  dadosIMCRepository: widget.dadosIMCRepository,
                  id: imc.id,
                );
              }
              return false;
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
                              "Calculo em: $formattedDate",
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
