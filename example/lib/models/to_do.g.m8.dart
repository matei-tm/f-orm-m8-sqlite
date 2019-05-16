// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2019-05-17 01:14:54.736273

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:sqlite_m8_demo/models/to_do.dart';

class ToDoProxy extends ToDo {
  DateTime dateCreate;
  DateTime dateUpdate;
  DateTime dateDelete;
  bool get isDeleted => dateDelete.year > 1970;

  ToDoProxy({accountId}) {
    this.accountId = accountId;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['description'] = description;
    map['diagnosys_date'] = diagnosysDate.millisecondsSinceEpoch;
    map['user_account_id'] = accountId;
    map['date_create'] = dateCreate.millisecondsSinceEpoch;
    map['date_update'] = dateUpdate.millisecondsSinceEpoch;
    // map['date_delete'] is handled by delete method

    return map;
  }

  ToDoProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.description = map['description'];
    this.diagnosysDate =
        DateTime.fromMillisecondsSinceEpoch(map['diagnosys_date']);
    this.accountId = map['user_account_id'];
    this.dateCreate = DateTime.fromMillisecondsSinceEpoch(map['date_create']);
    this.dateUpdate = DateTime.fromMillisecondsSinceEpoch(map['date_update']);
    this.dateDelete = DateTime.fromMillisecondsSinceEpoch(map['date_delete']);
  }
}

mixin ToDoDatabaseProvider {
  Future<Database> db;
  final theToDoColumns = [
    "id",
    "description",
    "diagnosys_date",
    "user_account_id",
    "date_create",
    "date_update",
    "date_delete"
  ];

  final String theToDoTableHandler = 'to_do';
  Future createToDoTable(Database db) async {
    await db.execute('''CREATE TABLE $theToDoTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE,
    description TEXT  UNIQUE,
    diagnosys_date INTEGER ,
    user_account_id INTEGER  NOT NULL UNIQUE,
    date_create INTEGER,
    date_update INTEGER,
    date_delete INTEGER DEFAULT 0
    )''');
    await db.execute(
        '''CREATE INDEX ix_${theToDoTableHandler}_description ON $theToDoTableHandler (description)''');
    await db.execute(
        '''CREATE INDEX ix_${theToDoTableHandler}_group1 ON $theToDoTableHandler (description, diagnosys_date)''');
  }

  Future<int> saveToDo(ToDoProxy instanceToDo) async {
    var dbClient = await db;

    instanceToDo.dateCreate = DateTime.now();
    instanceToDo.dateUpdate = DateTime.now();

    var result =
        await dbClient.insert(theToDoTableHandler, instanceToDo.toMap());
    return result;
  }

  Future<List<ToDoProxy>> getToDoProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(theToDoTableHandler,
        columns: theToDoColumns, where: 'date_delete > 0');

    return result.map((e) => ToDoProxy.fromMap(e)).toList();
  }

  Future<int> getToDoProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT COUNT(*) FROM $theToDoTableHandler  WHERE date_delete > 0'));
  }

  Future<ToDoProxy> getToDo(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(theToDoTableHandler,
        columns: theToDoColumns,
        where: 'date_delete > 0 AND id = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return ToDoProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteToDo(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(theToDoTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteToDoProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(theToDoTableHandler);
    return true;
  }

  Future<int> updateToDo(ToDoProxy instanceToDo) async {
    var dbClient = await db;

    instanceToDo.dateUpdate = DateTime.now();

    return await dbClient.update(theToDoTableHandler, instanceToDo.toMap(),
        where: "id = ?", whereArgs: [instanceToDo.id]);
  }

  Future<List<ToDoProxy>> getToDoProxiesByAccountId(int accountId) async {
    var dbClient = await db;
    var result = await dbClient.query(theToDoTableHandler,
        columns: theToDoColumns,
        where: 'user_account_id = ? AND date_delete > 0',
        whereArgs: [accountId]);

    return result.map((e) => ToDoProxy.fromMap(e)).toList();
  }

  Future<int> softdeleteToDo(int id) async {
    var dbClient = await db;

    var map = Map<String, dynamic>();
    map['date_delete'] = DateTime.now().millisecondsSinceEpoch;

    return await dbClient
        .update(theToDoTableHandler, map, where: "id = ?", whereArgs: [id]);
  }
}
