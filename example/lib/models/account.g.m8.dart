// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:example/models/account.dart';

class UserAccountProxy extends UserAccount {
  UserAccountProxy(abbreviation, email, userName) {
    this.abbreviation = abbreviation;
    this.email = email;
    this.userName = userName;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['my_id_column'] = id;
    map['my_description_column'] = description;
    map['my_abbreviation_column'] = abbreviation;
    map['my_email_column'] = email;
    map['my_userName_column'] = userName;
    return map;
  }

  UserAccountProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['my_id_column'];
    this.description = map['my_description_column'];
    this.abbreviation = map['my_abbreviation_column'];
    this.email = map['my_email_column'];
    this.userName = map['my_userName_column'];
  }
}

mixin UserAccountDatabaseHelper {
  Future<Database> db;
  final theUserAccountColumns = [
    "my_id_column",
    "my_description_column",
    "my_abbreviation_column",
    "my_email_column",
    "my_userName_column"
  ];

  final String _theUserAccountTableHandler = 'my_account_table';

  Future createUserAccountTable(Database db) async {
    await db.execute(
        'CREATE TABLE $_theUserAccountTableHandler (my_id_column INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE, my_description_column TEXT  UNIQUE, my_abbreviation_column TEXT  NOT NULL, my_email_column TEXT  NOT NULL, my_userName_column TEXT  NOT NULL)');
  }

  Future<int> saveUserAccount(UserAccountProxy instanceUserAccount) async {
    var dbClient = await db;
    var result = await dbClient.insert(
        _theUserAccountTableHandler, instanceUserAccount.toMap());
    return result;
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
        columns: theUserAccountColumns,
        where: '1 AND my_id_column = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return UserAccountProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteUserAccount(int id) async {
    var dbClient = await db;
    return await dbClient.delete(_theUserAccountTableHandler,
        where: 'my_id_column = ?', whereArgs: [id]);
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
        where: "my_id_column = ?", whereArgs: [instanceUserAccount.id]);
  }
}
