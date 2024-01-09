class DadosIMC {
  int _id = 0;
  double _peso;
  double _altura;
  double _result = 0.0;
  bool _isFavorite = false;
  String dateTime;

  DadosIMC(this._id, this._peso, this._altura, this._result,
      {required this.dateTime});

  int get id => _id;
  double get peso => _peso;
  double get altura => _altura;
  double get result => _result;
  bool get isFavorite => _isFavorite;

  set id(int id) {
    _id = id;
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
