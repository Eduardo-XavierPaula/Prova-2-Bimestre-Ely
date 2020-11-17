import 'dart:async';
import 'package:persistencia/model/filme.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

 void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE filme(id INTEGER PRIMARY KEY,nome TEXT, genero TEXT, ator TEXT, data TEXT)');
  }

  Future<int> inserirFilme(Filme filme) async {
    var dbClient = await db;
    var result = await dbClient.insert("filme", filme.toMap());
//é possivel executar comandos SQL
//var result = await dbClient.rawInsert(
//'INSERT INTO filme (nome, genero)
// VALUES (\'${filme.nome}\', \'${filme.genero}\')');
    return result;
  }

  Future<List> getFilmes() async {
    var dbClient = await db;
    var result =
        await dbClient.query("filme", columns: ["id", "nome", "genero", "ator", "data"]);
//var result = await dbClient.rawQuery('SELECT * FROM filme');
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM filme'));
  }
Future<int> updateFilme(Filme filme) async {
    var dbClient = await db;
    return await dbClient.update("filme", filme.toMap(),
        where: "id = ?", whereArgs: [filme.id]);


//return await dbClient.rawUpdate(
//'UPDATE $"filme" SET $columnTitle = \'${note.title}\',
// $columnDescription = \'${note.description}\' WHERE $columnId =
// ${note.id}');
  }
Future<int> deleteFilme(int id) async {
    var dbClient = await db;
    return await dbClient.delete("filme", where: '$id = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}

