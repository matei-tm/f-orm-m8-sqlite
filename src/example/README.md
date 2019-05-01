## Example - Gymspector application

A full, flutter working example is maintained on [https://github.com/matei-tm/flutter-sqlite-m8-generator/tree/master/example](https://github.com/matei-tm/flutter-sqlite-m8-generator/tree/master/example).  
The example presents different approaches to solve CRUD functionality for models that adhere to flutter-orm-m8 annotation framework.

### HealthEntry - A DbAccountRelatedEntity implementation

To demonstrate how to use a model that is dependent to UserAccount, we use a HealthEntry model that implements DbAccountRelatedEntity.
The model detain a composite unique constraint based on accountId and description.

![usecase002](https://github.com/matei-tm/flutter-sqlite-m8-generator/blob/master/example/docs/usecase002-320.gif)

#### The model

The model file `models/health_entry.dart` has the following content:

```dart
import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable(
    "health_entry", TableMetadata.trackCreate | TableMetadata.trackUpdate)
class HealthEntry implements DbAccountRelatedEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("diagnosys_date")
  DateTime diagnosysDate;

  @override
  @DataColumn("account_id",
      metadataLevel: ColumnMetadata.notNull,
      compositeConstraints: [
        CompositeConstraint(
            name: "uq_account_entry",
            constraintType: CompositeConstraintType.unique),
        CompositeConstraint(
            name: "ix_account_entry",
            constraintType: CompositeConstraintType.indexed)
      ])
  int accountId;

  @DataColumn("description",
      metadataLevel: ColumnMetadata.notNull,
      compositeConstraints: [
        CompositeConstraint(
            name: "uq_account_entry",
            constraintType: CompositeConstraintType.unique)
      ])
  String description;

  @DataColumn("my_future_column7",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;
}
```

#### The generated code

From the model, the builder creates `models/health_entry.g.m8.dart` file with content

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

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

mixin HealthEntryDatabaseHelper {
  Future<Database> db;
  final theHealthEntryColumns = [
    "id",
    "diagnosys_date",
    "account_id",
    "description",
    "date_create",
    "date_update"
  ];

  final String _theHealthEntryTableHandler = 'health_entry';
  Future createHealthEntryTable(Database db) async {
    await db.execute('''CREATE TABLE $_theHealthEntryTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE,
    diagnosys_date INTEGER ,
    account_id INTEGER  NOT NULL,
    description TEXT  NOT NULL,
    date_create INTEGER,
    date_update INTEGER    ,
    UNIQUE(account_id, description)
)''');
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

### GymLocation - A DbEntity implementation
