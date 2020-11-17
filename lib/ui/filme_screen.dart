import 'package:flutter/material.dart';

import 'package:persistencia/db/database_helper.dart';
import 'package:persistencia/model/filme.dart';

class FilmeScreen extends StatefulWidget {
  final Filme filme;
  FilmeScreen(this.filme);
  @override
  State<StatefulWidget> createState() => new _FilmeScreenState();
}

class _FilmeScreenState extends State<FilmeScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _generoController;
  TextEditingController _atorController;
  TextEditingController _dataController;
  @override
  void initState() {
    super.initState();
    _nomeController = new TextEditingController(text: widget.filme.nome);
    _generoController = new TextEditingController(text: widget.filme.genero);
    _atorController = new TextEditingController(text: widget.filme.ator);
    _dataController = new TextEditingController(text: widget.filme.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('Filme', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Colors.black38,
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(20),
                height: 130,               
                child: Image.network(
                  'https://catracalivre.com.br/wp-content/uploads/2018/03/Cinema-iStock.jpg',
                )),
            TextField(
                controller: _nomeController,
                style: TextStyle(color: Colors.orangeAccent),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.movie, color: Colors.yellow[300]),
                  labelText: 'Nome',
                  labelStyle: new TextStyle(color: Colors.yellow[300]),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow[300]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow[300]),
                  ),
                )),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
                controller: _generoController,
                style: TextStyle(color: Colors.orangeAccent),
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.local_movies, color: Colors.yellow[300]),
                  labelText: 'Gênero',
                  labelStyle: new TextStyle(color: Colors.yellow[300]),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow[300]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow[300]),
                  ),
                )),
            TextField(
                controller: _atorController,
                style: TextStyle(color: Colors.orangeAccent),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.yellow[300]),
                  labelText: 'Ator Principal',
                  labelStyle: new TextStyle(color: Colors.yellow[300]),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow[300]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow[300]),
                  ),
                )),
            TextField(
                controller: _dataController,
                style: TextStyle(color: Colors.orangeAccent),
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.calendar_today, color: Colors.yellow[300]),
                  labelText: 'Data de Estreia',
                  labelStyle: new TextStyle(color: Colors.yellow[300]),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow[300]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow[300]),
                  ),
                )),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              color: Colors.orangeAccent,
              child:
                  (widget.filme.id != null) ? Text('Alterar') : Text('Inserir'),
              onPressed: () {
                if (widget.filme.id != null) {
                  db
                      .updateFilme(Filme.fromMap({
                    'id': widget.filme.id,
                    'nome': _nomeController.text,
                    'genero': _generoController.text,
                    'ator': _atorController.text,
                    'data': _dataController.text
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .inserirFilme(Filme(
                    _nomeController.text,
                    _generoController.text,
                    _atorController.text,
                    _dataController.text,
                  ))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
