class Filme {
  int _id;
  String _nome;
  String _genero;
  String _ator;
  String _data;

  //construtor da classe
  Filme(this._nome, this._genero, this._ator, this._data);
  //converte dados de vetor para objeto
  Filme.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._genero = obj['genero'];
    this._ator = obj['ator'];
    this._data = obj['data'];
  }
  // encapsulamento
  int get id => _id;
  String get nome => _nome;
  String get genero => _genero;
  String get ator => _ator;
  String get data => _data;

 //converte o objeto em um map
 Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
       map['id'] = _id;
    }
    map['nome'] = _nome;
    map['genero'] = _genero;
    map['ator'] = _ator;
    map['data'] = _data;
    return map;
  }
  //converte map em um objeto
  Filme.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._genero = map['genero'];
    this._ator = map['ator'];
    this._data = map['data'];
  }
}


