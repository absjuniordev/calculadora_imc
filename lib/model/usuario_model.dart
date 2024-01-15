class UsuarioModel {
  int _id = 0;
  String _nome;
  double _altura;
  String _sexo;
  String _meta;
  String _photo;

  UsuarioModel(
    this._id,
    this._nome,
    this._altura,
    this._sexo,
    this._meta,
    this._photo,
  );

  int get id => this._id;
  String get nome => this._nome;
  double get altura => this._altura;
  String get sexo => this._sexo;
  String get meta => this._meta;
  String get photo => this._photo;

  set id(int id) => this._id = id;
  set nome(String nome) => this._nome = nome;
  set altura(double altura) => this._altura = altura;
  set sexo(String sexo) => this._sexo = sexo;
  set meta(String meta) => this._meta = meta;
  set photo(String photo) => this._photo = photo;

  @override
  String toString() {
    return 'UsuarioModel(_id: $_id, _nome: $_nome, _altura: $_altura, _sexo: $_sexo, _meta: $_meta, _photo: $_photo)';
  }
}
