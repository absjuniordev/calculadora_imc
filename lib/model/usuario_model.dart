// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsuarioModel {
  int _id = 0;
  String _nome;
  double _altura;
  String _sexo;
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
  String get sexo => this._sexo;
  String get meta => this._meta;

  set id(int id) => this._id = id;
  set nome(String nome) => this._nome = nome;
  set altura(double altura) => this._altura = altura;
  set sexo(String sexo) => this._sexo = sexo;
  set meta(String meta) => this._meta = meta;

  @override
  String toString() {
    return 'UsuarioModel(_id: $_id, _nome: $_nome, _altura: $_altura, _sexo: $_sexo, _meta: $_meta)';
  }
}
