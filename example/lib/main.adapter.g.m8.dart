// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DatabaseHelperGenerator
// **************************************************************************

import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:example/models/gym_location.g.m8.dart';
import 'package:example/models/health_entry.g.m8.dart';
import 'package:example/models/to_do.g.m8.dart';
import 'package:example/models/user_account.g.m8.dart';

class DatabaseHelper
    with
        GymLocationDatabaseHelper,
        HealthEntryDatabaseHelper,
        ToDoDatabaseHelper,
        UserAccountDatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static Database _db;

  /// if [extremeDevelopmentMode] is true then the database will be deleteted on each init
  bool extremeDevelopmentMode = true;

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
    await createGymLocationTable(db);
    await createHealthEntryTable(db);
    await createToDoTable(db);
    await createUserAccountTable(db);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future deleteAll() async {
    await deleteGymLocationProxiesAll();
    await deleteHealthEntryProxiesAll();
    await deleteToDoProxiesAll();
    await deleteUserAccountProxiesAll();
  }
}
