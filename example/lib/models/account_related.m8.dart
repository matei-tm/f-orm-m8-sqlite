// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
/*import 'package:/helpers/database/abstract_database_helper.dart';*/

mixin HealthEntryAccountRelatedDatabaseHelper /*implements AbstractDatabaseHelper*/ {
  Future<Database> db;
  final String columnId = 'id';
  final theHealthEntryAccountRelatedColumns = [
    "id",
    "account_id",
    "record_date",
    "is_deleted" /*, "entry_name"*/
  ];

  final String _theHealthEntryAccountRelatedTableHandler =
      'emittedEntity.entityName';

  Future createHealthEntryAccountRelatedTable(Database db) async {
    await db.execute(
        'CREATE TABLE $_theHealthEntryAccountRelatedTableHandler ($columnId INTEGER PRIMARY KEY, account_id INTEGER, record_date INTEGER, is_deleted INTEGER )');
  }

  Future<int> saveHealthEntryAccountRelated(
      HealthEntryAccountRelated instanceHealthEntryAccountRelated) async {
    var dbClient = await db;
    var result = await dbClient.insert(
        _theHealthEntryAccountRelatedTableHandler,
        instanceHealthEntryAccountRelated.toMap());
    return result;
  }

  Future<List> getHealthEntryAccountRelatedsAll() async {
    var dbClient = await db;
    var result = await dbClient.query(_theHealthEntryAccountRelatedTableHandler,
        columns: theHealthEntryAccountRelatedColumns, where: 'is_deleted != 1');

    return result.toList();
  }

  Future<List> getHealthEntryAccountRelatedsByAccountId(int accountId) async {
    var dbClient = await db;
    var result = await dbClient.query(_theHealthEntryAccountRelatedTableHandler,
        columns: theHealthEntryAccountRelatedColumns,
        where: 'account_id = ? AND is_deleted != 1',
        whereArgs: [accountId]);

    return result.toList();
  }

  Future<int> getHealthEntryAccountRelatedsCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT COUNT(*) FROM $_theHealthEntryAccountRelatedTableHandler  WHERE is_deleted != 1'));
  }

  Future<HealthEntryAccountRelated> getHealthEntryAccountRelated(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(
        _theHealthEntryAccountRelatedTableHandler,
        columns: theHealthEntryAccountRelatedColumns,
        where: '$columnId = ?  AND is_deleted != 1',
        whereArgs: [id]);

/*
if (result.length > 0) {
  return HealthEntryAccountRelated.fromMap(result.first);
}
*/

    return null;
  }

  Future<int> deleteHealthEntryAccountRelated(int id) async {
    var dbClient = await db;
    return await dbClient.delete(_theHealthEntryAccountRelatedTableHandler,
        where: '$columnId = ?', whereArgs: [id]);
  }

  Future<bool> deleteHealthEntryAccountRelatedsAll() async {
    var dbClient = await db;
    await dbClient.delete(_theHealthEntryAccountRelatedTableHandler);
    return true;
  }

  Future<int> updateHealthEntryAccountRelated(
      HealthEntryAccountRelated instanceHealthEntryAccountRelated) async {
    var dbClient = await db;
    return await dbClient.update(_theHealthEntryAccountRelatedTableHandler,
        instanceHealthEntryAccountRelated.toMap(),
        where: "$columnId = ?",
        whereArgs: [instanceHealthEntryAccountRelated.id]);
  }

  Future<int> softdeleteHealthEntryAccountRelated(int id) async {
    var dbClient = await db;

    var map = Map<String, dynamic>();
    map['is_deleted'] = 1;

    return await dbClient.update(_theHealthEntryAccountRelatedTableHandler, map,
        where: "$columnId = ?", whereArgs: [id]);
  }
}

//    Entity:my_account_related_table Model:HealthEntryAccountRelated
//{_id: Instance of 'EntityAttribute', _description: Instance of 'EntityAttribute', _account_id: Instance of 'EntityAttribute'}
