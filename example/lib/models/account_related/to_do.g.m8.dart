// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:example/models/account_related/to_do.dart';

class ToDoProxy extends ToDo {
  DateTime dateCreate;
  DateTime dateUpdate;

  ToDoProxy(accountId) {
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
  }
}

mixin ToDoDatabaseHelper {
  Future<Database> db;
  final theToDoColumns = [
    "id",
    "description",
    "diagnosys_date",
    "user_account_id",
    "date_create",
    "date_update"
  ];

  final String _theToDoTableHandler = 'to_do';

  Future createToDoTable(Database db) async {
    await db.execute(
        'CREATE TABLE $_theToDoTableHandler (id INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE, description TEXT  UNIQUE, diagnosys_date INTEGER , user_account_id INTEGER  NOT NULL UNIQUE, date_create INTEGER, date_update INTEGER)');
  }

  Future<int> saveToDo(ToDoProxy instanceToDo) async {
    var dbClient = await db;

    instanceToDo.dateCreate = DateTime.now();
    instanceToDo.dateUpdate = DateTime.now();

    var result =
        await dbClient.insert(_theToDoTableHandler, instanceToDo.toMap());
    return result;
  }

  Future<List> getToDosAll() async {
    var dbClient = await db;
    var result = await dbClient.query(_theToDoTableHandler,
        columns: theToDoColumns, where: '1');

    return result.toList();
  }

  Future<List> getToDosByAccountId(int accountId) async {
    var dbClient = await db;
    var result = await dbClient.query(_theToDoTableHandler,
        columns: theToDoColumns,
        where: 'account_id = ? AND 1',
        whereArgs: [accountId]);

    return result.toList();
  }

  Future<int> getToDosCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient
        .rawQuery('SELECT COUNT(*) FROM $_theToDoTableHandler  WHERE 1'));
  }

  Future<ToDo> getToDo(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(_theToDoTableHandler,
        columns: theToDoColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return ToDoProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteToDo(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(_theToDoTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteToDosAll() async {
    var dbClient = await db;
    await dbClient.delete(_theToDoTableHandler);
    return true;
  }

  Future<int> updateToDo(ToDoProxy instanceToDo) async {
    var dbClient = await db;

    instanceToDo.dateUpdate = DateTime.now();

    return await dbClient.update(_theToDoTableHandler, instanceToDo.toMap(),
        where: "id = ?", whereArgs: [instanceToDo.id]);
  }
}