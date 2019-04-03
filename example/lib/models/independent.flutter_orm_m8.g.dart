// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
/*import 'package:todo_currentProjectPackage_path/abstract_database_helper.dart';*/
import 'package:example/models/independent.dart';

class HealthEntryProxy extends HealthEntry {
  HealthEntryProxy();

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['my_id_column'] = id;
    map['my_description_column'] = description;
    return map;
  }

  HealthEntryProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['my_id_column'];
    this.description = map['my_description_column'];
  }
}

mixin HealthEntryDatabaseHelper /*implements AbstractDatabaseHelper*/ {
  Future<Database> db;
  final theHealthEntryColumns = ["my_id_column", "my_description_column"];

  final String _theHealthEntryTableHandler = 'my_health_entries_table';

  Future createHealthEntryTable(Database db) async {
    await db.execute(
        'CREATE TABLE $_theHealthEntryTableHandler (my_id_column INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE, my_description_column TEXT  UNIQUE, is_deleted INTEGER, date_create INTEGER, date_update INTEGER)');
  }

  Future<int> saveHealthEntry(HealthEntryProxy instanceHealthEntry) async {
    var dbClient = await db;
    var result = await dbClient.insert(
        _theHealthEntryTableHandler, instanceHealthEntry.toMap());
    return result;
  }

  Future<List> getHealthEntrysAll() async {
    var dbClient = await db;
    var result = await dbClient.query(_theHealthEntryTableHandler,
        columns: theHealthEntryColumns, where: 'is_deleted != 1');

    return result.toList();
  }

  Future<int> getHealthEntrysCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT COUNT(*) FROM $_theHealthEntryTableHandler  WHERE is_deleted != 1'));
  }

  Future<HealthEntry> getHealthEntry(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(_theHealthEntryTableHandler,
        columns: theHealthEntryColumns,
        where: 'is_deleted != 1 AND my_id_column = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return HealthEntryProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteHealthEntry(int id) async {
    var dbClient = await db;
    return await dbClient.delete(_theHealthEntryTableHandler,
        where: 'my_id_column = ?', whereArgs: [id]);
  }

  Future<bool> deleteHealthEntrysAll() async {
    var dbClient = await db;
    await dbClient.delete(_theHealthEntryTableHandler);
    return true;
  }

  Future<int> updateHealthEntry(HealthEntryProxy instanceHealthEntry) async {
    var dbClient = await db;
    return await dbClient.update(
        _theHealthEntryTableHandler, instanceHealthEntry.toMap(),
        where: "my_id_column = ?", whereArgs: [instanceHealthEntry.id]);
  }

  Future<int> softdeleteHealthEntry(int id) async {
    var dbClient = await db;

    var map = Map<String, dynamic>();
    map['is_deleted'] = 1;

    return await dbClient.update(_theHealthEntryTableHandler, map,
        where: "my_id_column = ?", whereArgs: [id]);
  }
}
