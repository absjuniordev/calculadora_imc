import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_p;

const scripts = {
  1: ''' CREATE TABLE IF NOT EXISTS imc (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          peso REAL,
          altura REAL,
          result REAL,
          favorite INTEGER,
          data TEXT
          );'''
};

class SQLiteDatabase {
  static Database? _db;

  Future<Database> obterBanco() async {
    if (_db == null) {
      return await iniciarBancoDeDados();
    }
    return _db!;
  }

  Future<Database> iniciarBancoDeDados() async {
    String path = path_p.join(await getDatabasesPath(), "calculadora_imc.db");
    // await deleteDatabase(path);
    var db = await openDatabase(
      path,
      version: scripts.length,
      onCreate: (db, version) async {
        for (var i = 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
          debugPrint(scripts[i]!);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (var i = oldVersion + 1; i <= scripts.length; i++) {
          await db.execute(scripts[i]!);
          debugPrint(scripts[i]!);
        }
      },
    );
    return db;
  }
}
