import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/dados_cadastrais_text_button.dart';
import '../shared/constants/custom_colors.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  var alturaController = TextEditingController();
  var nomeController = TextEditingController();
  var metaController = TextEditingController();
  String sexoEscolhido = "";
  double _alturaEscolhida = 120;
  final List<bool> _sexo = <bool>[false, false];

  String photo1 = "";
  XFile? photo;

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
          body: ListView(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromARGB(108, 158, 158, 158),
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                height: 570,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();

                        photo =
                            await picker.pickImage(source: ImageSource.camera);

                        if (photo != null) {
                          String path = (await path_provider
                                  .getApplicationDocumentsDirectory())
                              .path;
                          String name = basename(photo!.path);
                          await GallerySaver.saveImage(photo!.path);

                          await photo!.saveTo("$path/$name");
                          print('Caminho:  $path/$name');
                        }
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Card(
                            elevation: 25,
                            shape: const CircleBorder(),
                            child: Container(
                              height: 140,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: photo == null
                                  ? Image.asset(
                                      "assets/images/user.png",
                                      scale: 5,
                                    )
                                  : ClipOval(
                                      child: Image.file(
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        File(photo!.path),
                                        scale: 6,
                                      ),
                                    ),
                            ),
                          ),
                          const Card(
                            color: Colors.transparent,
                            elevation: 50,
                            child: Text(
                              "Adicionar foto",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          switch (_sexo) {
                            case [true, false]:
                              sexoEscolhido = 'Masculino';
                              break;
                            case [false, true]:
                              sexoEscolhido = 'Feminino';
                              break;
                          }
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
                            activeColor:
                                const Color.fromARGB(255, 16, 112, 190),
                            value: _alturaEscolhida,
                            min: 120,
                            max: 220,
                            onChanged: (double altura) {
                              setState(() {
                                _alturaEscolhida = altura;
                                alturaController.text =
                                    altura.toStringAsFixed(0).toString();
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
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromARGB(108, 158, 158, 158),
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                height: 70,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    DadosCadastraisTextButton(
                      altura: alturaController,
                      meta: metaController,
                      nome: nomeController,
                      photo: photo == null ? "" : photo!.path,
                      sexo: sexoEscolhido,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
