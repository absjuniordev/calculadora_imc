import 'package:calculadora_imc/components/home_floating_action_button.dart';
import 'package:calculadora_imc/model/dados_imc.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_repository.dart';
import 'package:flutter/material.dart';
import '../components/imc_listagem.dart';
import '../shared/constants/custom_colors.dart';

class IMCListagemPage extends StatefulWidget {
  const IMCListagemPage({super.key});

  @override
  State<IMCListagemPage> createState() => _IMCListagemPageState();
}

class _IMCListagemPageState extends State<IMCListagemPage> {
  var _imc = <DadosIMC>[];
  var dadosIMCRepository = SQLiteRepository();
  var pesoController = TextEditingController();
  late double alturaUsuario = 0.0;

  @override
  void initState() {
    obterIMC();
    super.initState();
  }

  obterIMC() async {
    _imc = await dadosIMCRepository.obterDadosIMC();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetFloatingActionButton(
        onUpdate:(){
           obterIMC();
        },
        peso: pesoController,
        altura: alturaUsuario,
        dadosIMCRepository: dadosIMCRepository,
      ),
      backgroundColor: CustomColors().scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 55),
            ListTile(
              title: const Text(
                "Calculadora ",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(
                context,
                
              );
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.157,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Historico de IMC",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: IMCListagem(
                      imcList: _imc,
                      update: obterIMC(),
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
