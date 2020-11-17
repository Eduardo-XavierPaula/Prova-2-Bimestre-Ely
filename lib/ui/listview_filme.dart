import 'package:flutter/material.dart';
import 'package:persistencia/ui/filme_screen.dart';
import 'package:persistencia/db/database_helper.dart';
import 'package:persistencia/model/filme.dart';

class ListViewFilme extends StatefulWidget {
  @override
  _ListViewFilmeState createState() => new _ListViewFilmeState();
}

class _ListViewFilmeState extends State<ListViewFilme> {
  List<Filme> items = new List();
  //conexão com banco de dados
  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getFilmes().then((filmes) {
      setState(() {
        filmes.forEach((filme) {
          items.add(Filme.fromMap(filme));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/images/Logo.png',
                    fit: BoxFit.cover,
                    height: 50.0,
                  ),
                  Text('Cadastro de Filme', style: TextStyle(color: Colors.black))
                ],
              ),                 
          backgroundColor: Colors.orangeAccent,
        ),
        backgroundColor: Colors.black38,
        body: Container(
        child:Center(          
          child: ListView.builder(
              itemCount: items.length,                
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(

                  children: [
                    Divider(height: 5.0),
                    
                      new Container (
                          decoration: new BoxDecoration (
                              color: Colors.yellow[300],
                              border:Border.all(width: 2.0, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(5),
                          ),

                    child: new ListTile(
                      title: Row(                      
                        children: <Widget>[
                          Flexible(
                            child: new Container(
                              padding: new EdgeInsets.only(right: 13.0),
                              child: new Text(
                                '${items[position].nome}',
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Roboto',
                                  color: new Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Flexible(
                            child: new Container(
                              padding: new EdgeInsets.only(right: 13.0),
                              child: new Text(
                                '${items[position].data}',
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Roboto',
                                  color: new Color(0xFF212121),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      
                      ],
                      ),
                      subtitle: Row(children: [
                        Text('${items[position].ator}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            )),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text('${items[position].genero}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            )),
                        IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _deleteFilme(
                                context, items[position], position)),
                            
                      ]),
                      leading: CircleAvatar(
                        backgroundColor: Colors.orangeAccent,
                        radius: 15.0,
                        child: Text(
                          '${items[position].id}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onTap: () => _navigateToFilme(context, items[position]),
                    ),
                    ),
                  ],
                );
              }),
        ),
        ),floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewFilme(context),
          backgroundColor: Colors.orangeAccent
        ),
      ),
    );
  }

  void _deleteFilme(BuildContext context, Filme filme, int position) async {
    db.deleteFilme(filme.id).then((filmes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToFilme(BuildContext context, Filme filme) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FilmeScreen(filme)),
    );
    if (result == 'update') {
      db.getFilmes().then((filmes) {
        setState(() {
          items.clear();
          filmes.forEach((filme) {
            items.add(Filme.fromMap(filme));
          });
        });
      });
    }
  }

  void _createNewFilme(BuildContext context) async {
    //aguarda o retorno da página de cadastro
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FilmeScreen(Filme('', '', '', ''))),
    );
    //se o retorno for salvar, recarrega a lista
    if (result == 'save') {
      db.getFilmes().then((filmes) {
        setState(() {
          items.clear();
          filmes.forEach((filme) {
            items.add(Filme.fromMap(filme));
          });
        });
      });
    }
  }
}
