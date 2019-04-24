# Sqlite ORM Mate Generator (flutter-sqlite-m8-generator)

![GitHub release](https://img.shields.io/github/release-pre/matei-tm/flutter-sqlite-m8-generator.svg) [![pub package](https://img.shields.io/pub/v/flutter_sqlite_m8_generator.svg)](https://pub.dartlang.org/packages/flutter_sqlite_m8_generator) [![Build Status](https://travis-ci.org/matei-tm/flutter-sqlite-m8-generator.svg?branch=master)](https://travis-ci.org/matei-tm/flutter-sqlite-m8-generator)

- [Sqlite ORM Mate Generator (flutter-sqlite-m8-generator)](#sqlite-orm-mate-generator-flutter-sqlite-m8-generator)
  - [Introduction](#introduction)
  - [Dependencies](#dependencies)
  - [Usage](#usage)
  - [Example](#example)
    - [A DbEntity implementation](#a-dbentity-implementation)


## Introduction

Dart package to generate SQLite ready-to-go fixture. Uses [Dart Build System](https://github.com/dart-lang/build) builders. Based on [flutter-orm-m8](https://github.com/matei-tm/flutter-orm-m8) annotations convention this package generates proxies and database adapter for SQLite.

## Dependencies

It depends on dart package [flutter-orm-m8](https://github.com/matei-tm/flutter-orm-m8). Read [README.md](https://github.com/matei-tm/flutter-orm-m8/blob/master/README.md) for implemented annotation convention.

## Usage

1. Create a flutter project
2. Add flutter_orm_m8, sqflite, build_runner, flutter_sqlite_m8_generator dependencies to `pubspec.yaml`

    - Before

        ```yaml
        dependencies:
            flutter:
                sdk: flutter

            cupertino_icons: ^0.1.2

        dev_dependencies:
            flutter_test:
                sdk: flutter
        ```

    - After

        ```yaml
        dependencies:
            flutter_orm_m8: ^0.6.0
            sqflite: ^1.1.0
            flutter:
                sdk: flutter

            cupertino_icons: ^0.1.2

        dev_dependencies:
            build_runner: ^1.0.0
            flutter_sqlite_m8_generator: ^0.2.3+1
            flutter_test:
                sdk: flutter

        ```        

3. Add build.yaml file with the following content

    ```yaml
    targets:
        $default:
            builders:
                flutter_sqlite_m8_generator|orm_m8:
                    generate_for:
                        - lib/models/*.dart
                        - lib/main.dart
    ```

4. Refresh packages
   
   ```bash
   flutter packages get
   ```

5. In the lib folder create a new one named `models`
6. In the models folder add model classes for your business objects.
7. Using [flutter-orm-m8](https://github.com/matei-tm/flutter-orm-m8) annotations convention mark:

   - classes with @DataTable
   - fields with @DataColumn
  
8. Run the build_runner
   
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

   The build_runner will generate:

    - in models folder, a *.g.m8.dart file for each model file
    - in lib folder, a main.adapter.g.m8.dart file

9. Use the generated proxies and adapter in order to easily develop CRUD behavior. See the example for a trivial usage.

## Example

A full, flutter working example is maintained on [https://github.com/matei-tm/flutter-sqlite-m8-generator/tree/master/example](https://github.com/matei-tm/flutter-sqlite-m8-generator/tree/master/example)

![usecase001](https://github.com/matei-tm/flutter-sqlite-m8-generator/blob/master/example/docs/usecase001-320.gif)

### A DbEntity implementation

We added a HealthEntry model that implements DbEntity. 
Adding a model file `independent/health_entry.dart` with the following content:

```dart
import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable(
    "health_entry", TableMetadata.TrackCreate | TableMetadata.TrackUpdate)
class HealthEntry implements DbAccountRelatedEntity {
  @DataColumn(
      "id",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int id;

  @DataColumn("description", ColumnMetadata.NotNull)
  String description;

  @DataColumn("diagnosys_date")
  DateTime diagnosysDate;

  @override
  @DataColumn("account_id", ColumnMetadata.NotNull)
  int accountId;

  @DataColumn(
      "my_future_column7", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int futureData;
}
```

the builder creates `independent/health_entry.g.m8.dart` file with content

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:example/models/health_entry.dart';

class HealthEntryProxy extends HealthEntry {
  DateTime dateCreate;
  DateTime dateUpdate;

  HealthEntryProxy({description, accountId}) {
    this.description = description;
    this.accountId = accountId;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['description'] = description;
    map['diagnosys_date'] = diagnosysDate.millisecondsSinceEpoch;
    map['account_id'] = accountId;
    map['date_create'] = dateCreate.millisecondsSinceEpoch;
    map['date_update'] = dateUpdate.millisecondsSinceEpoch;

    return map;
  }

  HealthEntryProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.description = map['description'];
    this.diagnosysDate =
        DateTime.fromMillisecondsSinceEpoch(map['diagnosys_date']);
    this.accountId = map['account_id'];
    this.dateCreate = DateTime.fromMillisecondsSinceEpoch(map['date_create']);
    this.dateUpdate = DateTime.fromMillisecondsSinceEpoch(map['date_update']);
  }
}

mixin HealthEntryDatabaseHelper {
  Future<Database> db;
  final theHealthEntryColumns = [
    "id",
    "description",
    "diagnosys_date",
    "account_id",
    "date_create",
    "date_update"
  ];

  final String _theHealthEntryTableHandler = 'health_entry';
  Future createHealthEntryTable(Database db) async {
    await db.execute(
        'CREATE TABLE $_theHealthEntryTableHandler (id INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE, description TEXT  NOT NULL, diagnosys_date INTEGER , account_id INTEGER  NOT NULL, date_create INTEGER, date_update INTEGER)');
  }

  Future<int> saveHealthEntry(HealthEntryProxy instanceHealthEntry) async {
    var dbClient = await db;

    instanceHealthEntry.dateCreate = DateTime.now();
    instanceHealthEntry.dateUpdate = DateTime.now();

    var result = await dbClient.insert(
        _theHealthEntryTableHandler, instanceHealthEntry.toMap());
    return result;
  }

  Future<List<HealthEntry>> getHealthEntryProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(_theHealthEntryTableHandler,
        columns: theHealthEntryColumns, where: '1');

    return result.map((e) => HealthEntryProxy.fromMap(e)).toList();
  }

  Future<int> getHealthEntryProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT COUNT(*) FROM $_theHealthEntryTableHandler  WHERE 1'));
  }

  Future<HealthEntry> getHealthEntry(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(_theHealthEntryTableHandler,
        columns: theHealthEntryColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return HealthEntryProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteHealthEntry(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(_theHealthEntryTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteHealthEntryProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(_theHealthEntryTableHandler);
    return true;
  }

  Future<int> updateHealthEntry(HealthEntryProxy instanceHealthEntry) async {
    var dbClient = await db;

    instanceHealthEntry.dateUpdate = DateTime.now();

    return await dbClient.update(
        _theHealthEntryTableHandler, instanceHealthEntry.toMap(),
        where: "id = ?", whereArgs: [instanceHealthEntry.id]);
  }

  Future<List<HealthEntry>> getHealthEntryProxiesByAccountId(
      int accountId) async {
    var dbClient = await db;
    var result = await dbClient.query(_theHealthEntryTableHandler,
        columns: theHealthEntryColumns,
        where: 'account_id = ? AND 1',
        whereArgs: [accountId]);

    return result.map((e) => HealthEntryProxy.fromMap(e)).toList();
  }
}
```

and database adapter file `main.adapter.g.m8.dart`

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DatabaseHelperGenerator
// **************************************************************************

import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:example/models/gym_location.g.m8.dart';
import 'package:example/models/health_entry.g.m8.dart';
import 'package:example/models/receipt.g.m8.dart';
import 'package:example/models/to_do.g.m8.dart';
import 'package:example/models/user_account.g.m8.dart';

class DatabaseHelper
    with
        GymLocationDatabaseHelper,
        HealthEntryDatabaseHelper,
        ReceiptDatabaseHelper,
        ToDoDatabaseHelper,
        UserAccountDatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static Database _db;

  /// if [extremeDevelopmentMode] is true then the database will be deleteted on each init
  bool extremeDevelopmentMode = false;

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
    await createReceiptTable(db);
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
    await deleteReceiptProxiesAll();
    await deleteToDoProxiesAll();
    await deleteUserAccountProxiesAll();
  }
}
```