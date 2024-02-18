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
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              SizedBox(height: size.height * .05),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromARGB(108, 158, 158, 158),
                ),
                margin: EdgeInsets.symmetric(
                  vertical: size.height * .01,
                  horizontal: size.width * .07,
                ),
                height: size.height * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * .05),
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
                        }
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Card(
                            elevation: 25,
                            shape: const CircleBorder(),
                            child: Container(
                              height: size.width / 2.9,
                              width: size.width / 2.9,
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
                                        width: size.width / 2.9,
                                        height: size.height / 2.9,
                                        fit: BoxFit.cover,
                                        File(photo!.path),
                                        scale: size.width / 2,
                                      ),
                                    ),
                            ),
                          ),
                          Card(
                            color: Colors.transparent,
                            elevation: 100,
                            child: Text(
                              "Adicionar foto",
                              style: TextStyle(
                                fontSize: size.height / 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: size.height / 45),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.height / 50),
                      elevation: 3,
                      color: const Color.fromARGB(131, 255, 255, 255),
                      child: TextField(
                        controller: nomeController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 16, 112, 190),
                            fontSize: size.height / 45,
                          ),
                          labelText: "Nome",
                        ),
                      ),
                    ),
                    SizedBox(height: size.height / 45),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.height / 45),
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
                        children: [
                          Text(
                            'Masculino',
                            style: TextStyle(
                              fontSize: size.height / 45,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Feminino',
                            style: TextStyle(
                              fontSize: size.height / 45,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height / 45),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.height / 45),
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
                            style: TextStyle(
                              fontSize: size.height / 45,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 16, 112, 190),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height / 40),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      elevation: 3,
                      color: const Color.fromARGB(131, 255, 255, 255),
                      child: TextField(
                        controller: metaController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 16, 112, 190),
                              fontSize: size.height / 45),
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
                margin: EdgeInsets.symmetric(
                  vertical: size.width / 45,
                  horizontal: size.width / 15,
                ),
                height: size.height / 14,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 90,
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
