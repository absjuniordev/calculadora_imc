import 'package:calculadora_imc/model/dados_imc.dart';
import 'package:calculadora_imc/repository/dados_imc_repositoty.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_repository.dart';
import 'package:calculadora_imc/shared/constants/custom_colors.dart';
import 'package:calculadora_imc/utils/custom_show_dialgo.dart';
import 'package:calculadora_imc/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class GetFloatingActionButton extends StatefulWidget {
  final TextEditingController peso;
  final SQLiteRepository dadosIMCRepository;
  final VoidCallback onUpdate;
  final double altura;
  const GetFloatingActionButton({
    super.key,
    required this.peso,
    required this.dadosIMCRepository,
    required this.onUpdate,
    required this.altura,
  });

  @override
  State<GetFloatingActionButton> createState() =>
      _GetFloatingActionButtonState();
}

class _GetFloatingActionButtonState extends State<GetFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: CustomColors().getGradientMainColor(),
      onPressed: () {
        widget.peso.clear();
        showDialog(
          useSafeArea: true,
          context: context,
          builder: (BuildContext bc) {
            return AlertDialog(
              title: const Text(
                "Informe seu Peso Ataual",
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 80,
                      child: CustomTextField(
                        keyboardType: TextInputType.number,
                        controller: widget.peso,
                        hintText: "Ex:85",
                        labelText: "Peso",
                        maxLengh: 3,
                        width: 80,
                      ),
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
                    if (widget.peso.text.isEmpty) {
                      customShowDialog(
                          delete: false,
                          title: "Error",
                          content: "A lacuna deve ser preenchida",
                          context: context);
                    } else {
                      var result = DadosIMCRepository.calculoIMC(
                        // widget.altura,
                        1.78,
                        double.parse(widget.peso.text),
                      );

                      await widget.dadosIMCRepository.salvarIMC(
                        DadosIMC(
                          dateTime: DateTime.now().toString(),
                          0,
                          double.parse(widget.peso.text),
                          widget.altura,
                          result,
                        ),
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      await widget.onUpdate;
                      setState(() {});
                    }
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
    );
  }
}
