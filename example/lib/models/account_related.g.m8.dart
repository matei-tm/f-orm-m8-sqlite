// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:example/models/account_related.dart';

class HealthEntryAccountRelatedProxy extends HealthEntryAccountRelated {
  HealthEntryAccountRelatedProxy(accountId) {
    this.accountId = accountId;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['my_id_column'] = id;
    map['my_description_column'] = description;
    map['my_account_id_column'] = accountId;
    return map;
  }

  HealthEntryAccountRelatedProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['my_id_column'];
    this.description = map['my_description_column'];
    this.accountId = map['my_account_id_column'];
  }
}

mixin HealthEntryAccountRelatedDatabaseHelper {
  Future<Database> db;
  final theHealthEntryAccountRelatedColumns = [
    "my_id_column",
    "my_description_column",
    "my_account_id_column"
  ];

  final String _theHealthEntryAccountRelatedTableHandler =
      'my_account_related_table';

  Future createHealthEntryAccountRelatedTable(Database db) async {
    await db.execute(
        'CREATE TABLE $_theHealthEntryAccountRelatedTableHandler (my_id_column INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE, my_description_column TEXT  UNIQUE, my_account_id_column INTEGER  NOT NULL)');
  }

  Future<int> saveHealthEntryAccountRelated(
      HealthEntryAccountRelatedProxy instanceHealthEntryAccountRelated) async {
    var dbClient = await db;
    var result = await dbClient.insert(
        _theHealthEntryAccountRelatedTableHandler,
        instanceHealthEntryAccountRelated.toMap());
    return result;
  }

  Future<List> getHealthEntryAccountRelatedsAll() async {
    var dbClient = await db;
    var result = await dbClient.query(_theHealthEntryAccountRelatedTableHandler,
        columns: theHealthEntryAccountRelatedColumns, where: '1');

    return result.toList();
  }

  Future<List> getHealthEntryAccountRelatedsByAccountId(int accountId) async {
    var dbClient = await db;
    var result = await dbClient.query(_theHealthEntryAccountRelatedTableHandler,
        columns: theHealthEntryAccountRelatedColumns,
        where: 'account_id = ? AND 1',
        whereArgs: [accountId]);

    return result.toList();
  }

  Future<int> getHealthEntryAccountRelatedsCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT COUNT(*) FROM $_theHealthEntryAccountRelatedTableHandler  WHERE 1'));
  }

  Future<HealthEntryAccountRelated> getHealthEntryAccountRelated(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(
        _theHealthEntryAccountRelatedTableHandler,
        columns: theHealthEntryAccountRelatedColumns,
        where: '1 AND my_id_column = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return HealthEntryAccountRelatedProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteHealthEntryAccountRelated(int id) async {
    var dbClient = await db;
    return await dbClient.delete(_theHealthEntryAccountRelatedTableHandler,
        where: 'my_id_column = ?', whereArgs: [id]);
  }

  Future<bool> deleteHealthEntryAccountRelatedsAll() async {
    var dbClient = await db;
    await dbClient.delete(_theHealthEntryAccountRelatedTableHandler);
    return true;
  }

  Future<int> updateHealthEntryAccountRelated(
      HealthEntryAccountRelatedProxy instanceHealthEntryAccountRelated) async {
    var dbClient = await db;
    return await dbClient.update(_theHealthEntryAccountRelatedTableHandler,
        instanceHealthEntryAccountRelated.toMap(),
        where: "my_id_column = ?",
        whereArgs: [instanceHealthEntryAccountRelated.id]);
  }
}
