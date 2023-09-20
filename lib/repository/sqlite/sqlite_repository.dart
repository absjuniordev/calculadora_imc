import 'package:calculadora_imc/model/dados_imc.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_database.dart';

class SQLiteRepository {
  Future<List<DadosIMC>> obterDados() async {
    List<DadosIMC> imc = [];

    var db = await SQLiteDatabase().obterBanco();
    var result = await db.rawQuery(
        'SELECT id, nome, altura, peso, result, favorite, data FROM imc');

    for (var element in result) {
      imc.add(DadosIMC(
        int.parse(element['id'].toString()),
        element['nome'].toString(),
        double.parse(element['peso'].toString()),
        double.parse(element['altura'].toString()),
        double.parse(element['result'].toString()),
      ));
    }
    return imc;
  }

  Future<void> salvar(DadosIMC dadosIMC) async {
    var db = await SQLiteDatabase().obterBanco();
    db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO imc(nome, peso, altura, result) VALUES(?, ?, ?, ?)',
          [dadosIMC.nome, dadosIMC.peso, dadosIMC.altura, dadosIMC.result]);
    });
  }

  Future<void> atualizar(DadosIMC dadosIMC) async {
    var db = await SQLiteDatabase().obterBanco();
    db.rawInsert('UPDATE imc SET peso = ?, WHERE id = ?', [
      dadosIMC.peso,
      dadosIMC.id,
    ]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDatabase().obterBanco();
    await db.rawDelete(
      'DELETE FROM imc WHERE id = ?',
      [id],
    );
  }
}
