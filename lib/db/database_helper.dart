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

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE army (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE statItem (
      id INTEGER PRIMARY KEY,
      color TEXT,
      name TEXT,
      imageText TEXT,
      movement TEXT,
      weaponSkill TEXT,
      ballisticSkill TEXT,
      strength TEXT,
      toughness TEXT,
      wounds TEXT,
      attacks TEXT,
      leadership TEXT,
      save TEXT
    )
    '''
    );

    await db.execute(
      '''
      CREATE TABLE armyStatItemPivot (
      statItemId INTEGER,
      armyId INTEGER,
      FOREIGN KEY (statItemId) REFERENCES statItem (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
      FOREIGN KEY (armyId) REFERENCES army (id) ON DELETE NO ACTION ON UPDATE NO ACTION
      )
      '''
    );
  }

  Future <int> insert(String table, Map<String,dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
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

  Future<int>  pivotDelete(String table, int itemId, int armyId) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'statItemId = ? AND armyId = ?', whereArgs: [itemId, armyId]);
  }

  Future<int>  pivotDeleteArmy(String table, int armyId) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'armyId = ?', whereArgs: [armyId]);
  }

  Future<List> specialQuery(int armyId) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM armyStatItemPivot JOIN statItem ON armyStatItemPivot.statItemId = statItem.id WHERE armyId = ? ', [armyId]);
  }

}