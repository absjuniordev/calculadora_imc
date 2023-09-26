import 'package:flutter/material.dart';
import '../shared/constants/custom_colors.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  double _alturaEscolhida = 121;

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
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromARGB(108, 158, 158, 158),
            ),
            margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 35),
            height: 600,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Dados",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 55),
                  const Card(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    elevation: 3,
                    color: Color.fromARGB(131, 255, 255, 255),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.blue),
                        labelText: "Nome",
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        elevation: 3,
                        color: Color.fromARGB(131, 255, 255, 255),
                        child: SizedBox(
                          width: 120,
                          height: 100,
                          child: Text("ioi'"),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        elevation: 3,
                        color: Color.fromARGB(131, 255, 255, 255),
                        child: SizedBox(
                          width: 120,
                          height: 100,
                          child: Text("ioi'"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 3,
                    color: const Color.fromARGB(131, 255, 255, 255),
                    child: Slider(
                      activeColor: Colors.blue,
                      inactiveColor: Color.fromARGB(255, 13, 179, 82),
                      value: _alturaEscolhida,
                      min: 120,
                      max: 250,
                      divisions: 9,
                      label: "Altura: ${_alturaEscolhida.toStringAsFixed(0)}",
                      onChanged: (double altura) {
                        setState(() {
                          _alturaEscolhida = altura;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Card(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    elevation: 3,
                    color: Color.fromARGB(131, 255, 255, 255),
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.blue),
                        labelText: "Meta",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
