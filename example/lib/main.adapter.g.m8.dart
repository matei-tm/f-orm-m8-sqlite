// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DatabaseHelperGenerator
// **************************************************************************

import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:example/models/independent/health_entry.g.m8.dart';

class DatabaseHelper with HealthEntryDatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static Database _db;

  /// if [extremeDevelopmentMode] is true then the database will be deleteted on each init
  bool extremeDevelopmentMode = false;

  factory DatabaseHelper() => _instance;
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
    String path = join(databasesPath, 'm8_store_0.2.0.db');

    if (extremeDevelopmentMode) {
      await deleteDatabase(path);
    }

    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await createHealthEntryTable(db);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future deleteAll() async {
    await deleteHealthEntrysAll();
  }
}
