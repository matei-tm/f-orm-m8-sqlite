// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2019-05-17 01:14:54.736273

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:sqlite_m8_demo/models/health_entry.dart';

class HealthEntryProxy extends HealthEntry {
  DateTime dateCreate;
  DateTime dateUpdate;

  HealthEntryProxy({accountId, description}) {
    this.accountId = accountId;
    this.description = description;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['diagnosys_date'] = diagnosysDate.millisecondsSinceEpoch;
    map['account_id'] = accountId;
    map['description'] = description;
    map['date_create'] = dateCreate.millisecondsSinceEpoch;
    map['date_update'] = dateUpdate.millisecondsSinceEpoch;

    return map;
  }

  HealthEntryProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.diagnosysDate =
        DateTime.fromMillisecondsSinceEpoch(map['diagnosys_date']);
    this.accountId = map['account_id'];
    this.description = map['description'];
    this.dateCreate = DateTime.fromMillisecondsSinceEpoch(map['date_create']);
    this.dateUpdate = DateTime.fromMillisecondsSinceEpoch(map['date_update']);
  }
}

mixin HealthEntryDatabaseProvider {
  Future<Database> db;
  final theHealthEntryColumns = [
    "id",
    "diagnosys_date",
    "account_id",
    "description",
    "date_create",
    "date_update"
  ];

  final String theHealthEntryTableHandler = 'health_entry';
  Future createHealthEntryTable(Database db) async {
    await db.execute('''CREATE TABLE $theHealthEntryTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE,
    diagnosys_date INTEGER ,
    account_id INTEGER  NOT NULL,
    description TEXT  NOT NULL,
    date_create INTEGER,
    date_update INTEGER    ,
    UNIQUE(account_id, description)
    )''');
    await db.execute(
        '''CREATE INDEX ix_${theHealthEntryTableHandler}_ix_account_entry ON $theHealthEntryTableHandler (account_id)''');
  }

  Future<int> saveHealthEntry(HealthEntryProxy instanceHealthEntry) async {
    var dbClient = await db;

    instanceHealthEntry.dateCreate = DateTime.now();
    instanceHealthEntry.dateUpdate = DateTime.now();

    var result = await dbClient.insert(
        theHealthEntryTableHandler, instanceHealthEntry.toMap());
    return result;
  }

  Future<List<HealthEntryProxy>> getHealthEntryProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(theHealthEntryTableHandler,
        columns: theHealthEntryColumns, where: '1');

    return result.map((e) => HealthEntryProxy.fromMap(e)).toList();
  }

  Future<int> getHealthEntryProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient
        .rawQuery('SELECT COUNT(*) FROM $theHealthEntryTableHandler  WHERE 1'));
  }

  Future<HealthEntryProxy> getHealthEntry(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(theHealthEntryTableHandler,
        columns: theHealthEntryColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return HealthEntryProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteHealthEntry(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(theHealthEntryTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteHealthEntryProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(theHealthEntryTableHandler);
    return true;
  }

  Future<int> updateHealthEntry(HealthEntryProxy instanceHealthEntry) async {
    var dbClient = await db;

    instanceHealthEntry.dateUpdate = DateTime.now();

    return await dbClient.update(
        theHealthEntryTableHandler, instanceHealthEntry.toMap(),
        where: "id = ?", whereArgs: [instanceHealthEntry.id]);
  }

  Future<List<HealthEntryProxy>> getHealthEntryProxiesByAccountId(
      int accountId) async {
    var dbClient = await db;
    var result = await dbClient.query(theHealthEntryTableHandler,
        columns: theHealthEntryColumns,
        where: 'account_id = ? AND 1',
        whereArgs: [accountId]);

    return result.map((e) => HealthEntryProxy.fromMap(e)).toList();
  }
}
