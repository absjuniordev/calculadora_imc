import 'package:flutter/material.dart';
import '../model/usuario_model.dart';
import '../repository/sqlite/sqlite_repository.dart';
import '../shared/constants/custom_colors.dart';
import '../utils/custom_show_dialgo.dart';

class DadosCadastraisTextButton extends StatefulWidget {
  final TextEditingController nome;
  final TextEditingController altura;
  final TextEditingController meta;
  final String sexo;
  final String? photo;

  const DadosCadastraisTextButton({
    super.key,
    required this.nome,
    required this.altura,
    required this.meta,
    required this.sexo,
    this.photo,
  });

  @override
  State<DadosCadastraisTextButton> createState() =>
      _DadosCadastraisTextButtonState();
}

class _DadosCadastraisTextButtonState extends State<DadosCadastraisTextButton> {
  var usuarioIMCRepository = SQLiteRepository();
  var _usuario = <UsuarioModel>[];

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  obterIMC() async {
    _usuario = await usuarioIMCRepository.obterDadosUsuario();

    setState(() {});
    debugPrint(_usuario.toString());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: size.width / 25),
      elevation: 3,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomColors().getGradientMainColor(),
              CustomColors().getGradientSecondaryColor(),
            ],
          ),
        ),
        width: size.width / 1,
        height: size.height / 20,
        child: TextButton(
          onPressed: () async {
            if (widget.nome.text.isEmpty) {
              customShowDialog(
                content: "Nome é obrigatório.",
                context: context,
                title: "Atenção",
                delete: false,
              );
            } else if (widget.nome.text.contains(RegExp(r'[0-9]'))) {
              customShowDialog(
                content: "Invalido formato para um nome",
                context: context,
                title: "Atenção",
                delete: false,
              );
            } else if (widget.sexo.isEmpty) {
              customShowDialog(
                content: "Selecione o sexo..",
                context: context,
                title: "Atenção",
                delete: false,
              );
            } else if (widget.altura.text.isEmpty) {
              customShowDialog(
                content: "Altura é obrigatória.",
                context: context,
                title: "Atenção",
                delete: false,
              );
            } else if (widget.meta.text.isEmpty) {
              customShowDialog(
                content: "Meta é obrigatória..",
                context: context,
                title: "Atenção",
                delete: false,
              );
            } else {
              await usuarioIMCRepository.salvarUsuario(
                UsuarioModel(
                  0,
                  widget.nome.text,
                  double.parse(widget.altura.text),
                  widget.sexo,
                  widget.meta.text,
                  widget.photo == null ? "" : widget.photo!,
                ),
              );
              Future.delayed(const Duration(seconds: 2), () {
                const CircularProgressIndicator();
                Navigator.of(context).pushReplacementNamed('/home_screen');
              });
            }
          },
          child: Text(
            "ENTRAR",
            style: TextStyle(
              color: const Color.fromARGB(255, 16, 112, 190),
              fontSize: size.width / 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
