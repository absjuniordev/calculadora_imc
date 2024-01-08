import 'package:calculadora_imc/model/dados_imc.dart';

class DadosIMCRepository {
  final List<DadosIMC> _imc = [];

  static double result = 0.0;
  var peso = 0.0;
  var altura = 0.0;

  addIMC(DadosIMC imc) async {
    await Future.delayed(const Duration(milliseconds: 0));
    _imc.insert(0, imc);
    _imc.add(imc);
  }

  removeIMC(DadosIMC imc) async {
    await Future.delayed(const Duration(milliseconds: 0));
    _imc.remove(imc);
  }

  Future<List<DadosIMC>> listasIMC() async {
    await Future.delayed(const Duration(milliseconds: 0));
    return _imc;
  }

  static double calculoIMC(double altura, double peso) {
    if (altura <= 0 || peso <= 0) {
      throw ArgumentError('Altura e peso devem ser valores positivos.');
    }

    double resultado = peso / (altura * altura);
    return resultado;
  }
}
