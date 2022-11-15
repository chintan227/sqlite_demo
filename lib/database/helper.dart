import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_database_demo/model.dart';

///class for favourite
class Favourite_Helper {
  static final Favourite_Helper _instance = Favourite_Helper.internal();

  ///get instance
  factory Favourite_Helper() => _instance;

  static Database? database;

  Favourite_Helper.internal();

  ///get database
  Future<Database?> get dataBase async {
    if (database != null) {
      return database;
    }
    database = await initDb();
    return database;
  }

  ///initialise favourite database
  Future<Database?> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'database.db');

    final File file = File(path);
    if (!file.existsSync()) {
      database =  await openDatabase(path, version: 1, onOpen: (db) {},
          onCreate: (Database db, int version) async {
        await db.execute('''
      CREATE TABLE Client (Id INTEGER PRIMARY KEY autoincrement,  fname TEXT, lname TEXT
      )
      ''');
      }).whenComplete(() => print("----------"));
    } else {
      print('database exist');
      database = await openDatabase(
        path,
        version: 1,
        readOnly: false,
      );
    }
    return database;
  }

  Future insertQuery() async {
    final db = await dataBase;
    print("id--->00");

    Map<String, dynamic> row = {
      "Id": 6,
      "fname": "Chi",
      "lname": "ge",
    };
    int id = await db!.insert("Client", row);
    print("id--->$id");
  }

  Future getAllData() async {
    final dba = await dataBase;
    final List<Map<String, dynamic>> maps = await dba!.query('Client');
    print("maps1--->$maps");
    return maps;
  }

  Future updateQuery() async {
    final dba = await dataBase;
    Map<String, dynamic> row = {"Id": 8, "fname": "raj", "lname": "patel",};
    await dba!.update("Client", row, where: "Id = 5",);
    final List<Map<String, dynamic>> map = await dba.query('Client');
    print("maps1--->$map");
  }

  Future deleteQuery() async {
    final dba = await dataBase;
    await dba!.delete('Client', where: "Id = 8");
    final List<Map<String, dynamic>> map = await dba.query('Client');
    print("maps--->$map");
  }

  Future<void> close() async {
    Database? dbClient = await (dataBase);
    return dbClient!.close();
  }
}
