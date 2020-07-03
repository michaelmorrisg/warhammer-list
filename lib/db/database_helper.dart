import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final _dbName = 'warhammerApp.db';
  static final _dbVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initiateDatabase();
      return _database;
    }
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute(
      '''
      CREATE TABLE army (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
      )
      '''
    );
  }

  Future <int> insert(Map<String,dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('army', row); //need to make 'army' dynamic once we figure this out
  }

  Future<List<Map<String,dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query('army'); //same here
  }

  Future<int> update(Map<String,dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update('army', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int>  delete(int id) async {
    Database db = await instance.database;
    return await db.delete('army', where: 'id = ?', whereArgs: [id]);
  }

}