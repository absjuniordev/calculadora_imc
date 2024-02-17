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
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: GetFloatingActionButton(
          onUpdate: () {
            obterIMC();
          },
          peso: pesoController,
          altura: alturaUsuario,
          dadosIMCRepository: dadosIMCRepository,
        ),
        body: Container(
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
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),
              ListTile(
                title: Text(
                  "Calculadora ",
                  style: TextStyle(
                    fontSize: size.height * 0.04,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: size.height * 0.035,
                    left: size.width * 0.06,
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 234, 234),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Historico IMC",
                        style: TextStyle(
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      IMCListagem(
                        imcList: _imc,
                        update: obterIMC(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
