// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:example/models/user_account.dart';

class UserAccountProxy extends UserAccount {
  UserAccountProxy(abbreviation, email, userName) {
    this.abbreviation = abbreviation;
    this.email = email;
    this.userName = userName;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['description'] = description;
    map['abbreviation'] = abbreviation;
    map['email'] = email;
    map['user_name'] = userName;
    map['is_current'] = isCurrent;
    return map;
  }

  UserAccountProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.description = map['description'];
    this.abbreviation = map['abbreviation'];
    this.email = map['email'];
    this.userName = map['user_name'];
    this.isCurrent = map['is_current'];
  }
}

mixin UserAccountDatabaseHelper {
  Future<Database> db;
  final theUserAccountColumns = [
    "id",
    "description",
    "abbreviation",
    "email",
    "user_name",
    "is_current"
  ];

  final String _theUserAccountTableHandler = 'user_account';

  Future createUserAccountTable(Database db) async {
    await db.execute(
        'CREATE TABLE $_theUserAccountTableHandler (id INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE, description TEXT  UNIQUE, abbreviation TEXT  NOT NULL, email TEXT  NOT NULL, user_name TEXT  NOT NULL, is_current INTEGER )');
  }

  Future<int> saveUserAccount(UserAccountProxy instanceUserAccount) async {
    var dbClient = await db;

    var result = await dbClient.insert(
        _theUserAccountTableHandler, instanceUserAccount.toMap());
    return result;
  }

  Future<UserAccount> getCurrentUserAccount() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(_theUserAccountTableHandler,
        columns: theUserAccountColumns, where: '1 AND is_current = 1');

    if (result.length > 0) {
      return UserAccountProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> setCurrentUserAccount(int id) async {
    var dbClient = await db;

    var map = Map<String, dynamic>();
    map['is_current'] = 0;

    await dbClient.update(_theUserAccountTableHandler, map,
        where: "is_current = 1");

    map['is_current'] = 1;
    return await dbClient.update(_theUserAccountTableHandler, map,
        where: "1 AND id = ?", whereArgs: [id]);
  }

  Future<List> getUserAccountsAll() async {
    var dbClient = await db;
    var result = await dbClient.query(_theUserAccountTableHandler,
        columns: theUserAccountColumns, where: '1');

    return result.toList();
  }

  Future<int> getUserAccountsCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT COUNT(*) FROM $_theUserAccountTableHandler  WHERE 1'));
  }

  Future<UserAccount> getUserAccount(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(_theUserAccountTableHandler,
        columns: theUserAccountColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return UserAccountProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteUserAccount(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(_theUserAccountTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteUserAccountsAll() async {
    var dbClient = await db;
    await dbClient.delete(_theUserAccountTableHandler);
    return true;
  }

  Future<int> updateUserAccount(UserAccountProxy instanceUserAccount) async {
    var dbClient = await db;

    return await dbClient.update(
        _theUserAccountTableHandler, instanceUserAccount.toMap(),
        where: "id = ?", whereArgs: [instanceUserAccount.id]);
  }
}
