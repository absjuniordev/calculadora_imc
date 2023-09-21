// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:intl/intl.dart';

class DadosIMC {
  int _id = 0;
  String _nome;
  double _peso;
  double _altura;
  double _result = 0.0;
  bool _isFavorite = false;
  final String _dateTime =
      DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

  DadosIMC(
    this._id,
    this._nome,
    this._peso,
    this._altura,
    this._result,
  );

  String get dateTime => _dateTime;
  int get id => _id;
  double get peso => _peso;
  double get altura => _altura;
  String get nome => _nome;
  double get result => _result;
  bool get isFavorite => _isFavorite;

  set id(int id) {
    _id = id;
  }

  set nome(String nome) {
    _nome = nome;
  }

  set peso(double peso) {
    _peso = peso;
  }

  set altura(double altura) {
    _altura = altura;
  }

  set result(double result) {
    _result = result;
  }

  set isFavorite(bool isFavorite) {
    _isFavorite = isFavorite;
  }
}
