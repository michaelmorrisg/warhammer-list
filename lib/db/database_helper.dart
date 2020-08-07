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

    db.execute(
      '''
      CREATE TABLE stat-item (
      id INTEGER PRIMARY KEY,
      color TEXT;
      name TEXT;
      imageText TEXT;
      movement TEXT;
      weaponSkill TEXT;
      ballisticSkill TEXT;
      strength TEXT;
      toughness TEXT;
      wounds TEXT;
      attacks TEXT;
      leadership TEXT;
      save TEXT;
    )
    '''
    );
  }

  Future <int> insert(String table, Map<String,dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row); //need to make 'army' dynamic once we figure this out
  }

  Future<List<Map<String,dynamic>>> queryAll(String table) async {
    Database db = await instance.database;
    return await db.query(table); //same here
  }

  Future<int> update(String table, Map<String,dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int>  delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

}