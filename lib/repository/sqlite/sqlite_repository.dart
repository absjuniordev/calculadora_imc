import 'package:calculadora_imc/model/dados_imc.dart';
import 'package:calculadora_imc/model/usuario_model.dart';
import 'package:calculadora_imc/repository/sqlite/sqlite_database.dart';
import 'package:flutter/material.dart';

class SQLiteRepository {
  //#Dados
  Future<List<DadosIMC>> obterDadosIMC() async {
    List<DadosIMC> imc = [];

    var db = await SQLiteDatabase().obterBanco();
    var imcResul = await db.rawQuery(
        'SELECT id, altura, peso, result, favorite, data FROM imc ORDER BY data DESC');

    for (var element in imcResul) {
      imc.add(DadosIMC(
        int.parse(element['id'].toString()),
        double.parse(element['peso'].toString()),
        double.parse(element['altura'].toString()),
        double.parse(element['result'].toString()),
        dateTime: element['data'].toString(),
      ));
    }

    imc.sort(
      (a, b) => DateTime.parse(b.dateTime).compareTo(
        DateTime.parse(a.dateTime),
      ),
    );

    return imc;
  }

  //#Usuario
  Future<List<UsuarioModel>> obterDadosUsuario() async {
    List<UsuarioModel> usuario = [];

    var db = await SQLiteDatabase().obterBanco();

    var usuarioResul = await db
        .rawQuery('SELECT id, nome, altura, sexo, meta, photo FROM usuario');

    for (var element in usuarioResul) {
      usuario.add(
        UsuarioModel(
          int.parse(element['id'].toString()),
          element['nome'].toString(),
          double.parse(element['altura'].toString()),
          element['sexo'].toString(),
          element['meta'].toString(),
          element['photo'].toString(),
        ),
      );
    }
    // debugPrint(usuarioResul.toString());

    return usuario;
  }

  Future<void> salvarIMC(DadosIMC dadosIMC) async {
    var db = await SQLiteDatabase().obterBanco();

    db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO imc(peso, altura, result, data) VALUES(?, ?, ?,?)', [
        dadosIMC.peso,
        dadosIMC.altura,
        dadosIMC.result,
        dadosIMC.dateTime,
      ]);
    });

  }

  Future<void> salvarUsuario(UsuarioModel usuarioModel) async {
    var db = await SQLiteDatabase().obterBanco();

    db.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO usuario(nome, altura, sexo, meta, photo) VALUES(?, ?, ?, ?, ?)', [
        usuarioModel.nome,
        usuarioModel.altura,
        usuarioModel.sexo,
        usuarioModel.meta,
        usuarioModel.photo,
      ]);
    });
  }

  Future<void> atualizarIMC(DadosIMC dadosIMC) async {
    var db = await SQLiteDatabase().obterBanco();

    db.transaction((txn) async {
      txn.rawInsert('UPDATE imc SET peso = ? WHERE id = ?', [
        dadosIMC.peso,
        dadosIMC.id,
      ]);
    });
  }

  Future<void> removerIMC(int id) async {
    var db = await SQLiteDatabase().obterBanco();
    await db.rawDelete(
      'DELETE FROM imc WHERE id = ?',
      [id],
    );
  }
}
