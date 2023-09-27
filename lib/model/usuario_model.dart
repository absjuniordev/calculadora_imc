// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsuarioModel {
  int _id = 0;
  String _nome;
  double _altura;
  bool _sexo;
  String _meta;

  UsuarioModel(
    this._id,
    this._nome,
    this._altura,
    this._sexo,
    this._meta,
  );

  int get id => this._id;
  String get nome => this._nome;
  double get altura => this._altura;
  bool get sexo => this._sexo;
  String get meta => this._meta;

  set id(int id) => this._id = id;
  set nome(String nome) => this._nome = nome;
  set altura(double altura) => this._altura = altura;
  set sexo(bool sexo) => this._sexo = sexo;
  set meta(String meta) => this._meta = meta;
}
