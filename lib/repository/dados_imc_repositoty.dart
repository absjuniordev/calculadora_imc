import 'package:calculadora_imc/model/dados_imc.dart';

class DadosIMCRepository {
  final List<DadosIMC> _imc = [];
  double result = 0.0;

  addIMC(DadosIMC imc) async {
    await Future.delayed(const Duration(milliseconds: 0));
    _imc.add(imc);
  }

  removeIMC(DadosIMC imc) async {
    await Future.delayed(const Duration(milliseconds: 0));
    _imc.remove(imc);
  }

  Future<void> alterarTarefa(String id, bool concluido) async {
    await Future.delayed(const Duration(milliseconds: 0));
    _imc.where((tarefa) => tarefa.id == id).first.isFavorite = concluido;
  }

  removeItem(String id) async {
    await Future.delayed(const Duration(milliseconds: 0));
    _imc.remove(_imc.where((imc) => imc.id == id).first);
  }

  Future<List<DadosIMC>> listasIMC() async {
    await Future.delayed(const Duration(milliseconds: 0));
    return _imc;
  }
}
