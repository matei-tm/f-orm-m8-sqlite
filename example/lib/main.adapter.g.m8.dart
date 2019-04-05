// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DatabaseHelperGenerator
// **************************************************************************

import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:example/models/independent.g.m8.dart';
import 'package:example/models/account_related.g.m8.dart';
import 'package:example/models/account.g.m8.dart';

class DatabaseHelper
    with
        HealthEntryDatabaseHelper,
        HealthEntryAccountRelatedDatabaseHelper,
        UserAccountDatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'm8_store_0.1.0.db');

    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await createHealthEntryTable(db);
    await createHealthEntryAccountRelatedTable(db);
    await createUserAccountTable(db);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future deleteAll() async {
    await deleteHealthEntrysAll();
    await deleteHealthEntryAccountRelatedsAll();
    await deleteUserAccountsAll();
  }
}
