# Sqlite Scaffolding Generator @ Dart Framework ORM M8

[![Gitter](https://img.shields.io/gitter/room/flutter-orm-m8/community.svg)](https://gitter.im/flutter-orm-m8/community) 
[![GitHub release](https://img.shields.io/github/release-pre/matei-tm/f-orm-m8-sqlite.svg)](https://github.com/matei-tm/f-orm-m8-sqlite/releases/) 
[![pub package](https://img.shields.io/pub/v/f_orm_m8_sqlite.svg)](https://pub.dartlang.org/packages/f_orm_m8_sqlite) 
[![Build Status](https://travis-ci.org/matei-tm/f-orm-m8-sqlite.svg?branch=master)](https://travis-ci.org/matei-tm/f-orm-m8-sqlite) 
[![Codecov](https://img.shields.io/codecov/c/github/matei-tm/f-orm-m8-sqlite.svg)](https://codecov.io/gh/matei-tm/f-orm-m8-sqlite) 
[![license](https://img.shields.io/github/license/matei-tm/f-orm-m8-sqlite.svg)](LICENSE)

> f_orm_m8_sqlite - \fɔːrm meɪt Ess-kjuː-ɛl-aɪ\ A [f_orm_m8](https://github.com/matei-tm/f-orm-m8) implementation for Sqlite, with mapping capability out of the box. Part of Dart Framework ORM **M8**

- [Sqlite Scaffolding Generator @ Dart Framework ORM M8](#sqlite-scaffolding-generator--dart-framework-orm-m8)
  - [Introduction](#introduction)
  - [Dependencies](#dependencies)
  - [Usage](#usage)
  - [Example - Gymspector application](#example---gymspector-application)
    - [UserAccount - A DbAccountEntity implementation](#useraccount---a-dbaccountentity-implementation)
      - [The model](#the-model)
      - [The generated code](#the-generated-code)
      - [The generated code](#the-generated-code-1)
    - [GymLocation - A DbEntity implementation](#gymlocation---a-dbentity-implementation)
      - [The model](#the-model-1)
      - [The generated code](#the-generated-code-2)
    - [Receipt - A DbEntity implementation](#receipt---a-dbentity-implementation)
      - [The model](#the-model-2)
      - [The generated code](#the-generated-code-3)
    - [The database adapter](#the-database-adapter)


## Introduction

Dart package to generate SQLite ready-to-go fixture. Uses [Dart Build System](https://github.com/dart-lang/build) builders. Based on [f_orm_m8](https://github.com/matei-tm/f-orm-m8) annotations convention this package generates proxies and database adapter for SQLite.

## Dependencies

It depends on dart package [f_orm_m8](https://github.com/matei-tm/f-orm-m8). Read [README.md](https://github.com/matei-tm/f-orm-m8/blob/master/README.md) for implemented annotation convention.

Supported orm-m8 features:

| Prefix               | Framework gem          | Type                | Generator version | Notes              |
| -------------------- | ---------------------- | ------------------- | ----------------- | ------------------ |
| @                    | DataTable              | class annotation    | v0.1.0            |                    |
| @                    | DataColumn             | field annotation    | v0.1.0            |                    |
| TableMetadata.       | softDeletable          | TableMetadata       | v0.3.0            |                    |
| TableMetadata.       | trackCreate            | TableMetadata       | v0.3.0            |                    |
| TableMetadata.       | trackUpdate            | TableMetadata       | v0.1.0            |                    |
| ColumnMetadata.      | ignore                 | ColumnMetadata      | v0.1.0            |                    |
| ColumnMetadata.      | primaryKey             | ColumnMetadata      | v0.1.0            |                    |
| ColumnMetadata.      | unique                 | ColumnMetadata      | v0.1.0            |                    |
| ColumnMetadata.      | notNull                | ColumnMetadata      | v0.1.0            |                    |
| ColumnMetadata.      | autoIncrement          | ColumnMetadata      | v0.3.0            |                    |
| ColumnMetadata.      | indexed                | ColumnMetadata      | v0.7.0            |                    |
| CompositeConstraint. | unique                 | CompositeConstraint | v0.4.0            |                    |
| CompositeConstraint. | primaryKey             | CompositeConstraint | v0.4.0            |                    |
| CompositeConstraint. | foreignKey             | CompositeConstraint | -                 | Planned for v0.9.0 |
| CompositeConstraint. | indexed                | CompositeConstraint | v0.7.0            |                    |
| implements           | DbOpenEntity           | entity helper       | v0.6.3            |                    |
| implements           | DbEntity               | entity helper       | v0.1.0            |                    |
| implements           | DbAccountEntity        | entity helper       | v0.1.0            |                    |
| implements           | DbAccountRelatedEntity | entity helper       | v0.1.0            |                    |


## Usage

1. Create a flutter project
2. Add f_orm_m8, sqflite, build_runner, f_orm_m8_sqlite dependencies to `pubspec.yaml`

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
            f_orm_m8: ^0.8.0
            sqflite: ^1.1.0
            flutter:
                sdk: flutter

            cupertino_icons: ^0.1.2

        dev_dependencies:
            build_runner: ^1.0.0
            f_orm_m8_sqlite: ^0.7.0
            flutter_test:
                sdk: flutter

        ```        

3. Add build.yaml file with the following content

    ```yaml
    targets:
        $default:
            builders:
                f_orm_m8_sqlite|orm_m8:
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
7. Using [f_orm_m8](https://github.com/matei-tm/f-orm-m8) annotations convention, mark:

   - classes with @DataTable
   - fields with @DataColumn
  
8. Run the build_runner clean. This step is absolutely mandatory.

  ```bash
  flutter packages pub run build_runner clean
  ```
  

9. Run the build_runner build

  ```bash
  flutter packages pub run build_runner build --delete-conflicting-outputs
  ```

  The build_runner will generate:

  - in models folder, a `*.g.m8.dart` file for each model file
  - in lib folder, a `main.adapter.g.m8.dart` file

10. Use the generated proxies and adapter in order to easily develop CRUD behavior. See the example project for a trivial usage.

## Example - Gymspector application

A full, flutter working example is maintained on [https://github.com/matei-tm/f-orm-m8-sqlite/tree/master/example](https://github.com/matei-tm/f-orm-m8-sqlite/tree/master/example).  
The example presents different approaches to solve CRUD functionality for models that adhere to f_orm_m8 annotation framework.

![usecase000](example/docs/usecase000-320.gif)


### UserAccount - A DbAccountEntity implementation

The example has a common UserAccount model that implements DbAccountEntity

![usecase001](example/docs/usecase001-320.gif)

#### The model

The model file `models/user_account.dart` has the following content:

```dart
import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("user_account")
class UserAccount implements DbAccountEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("description")
  String description;

  @DataColumn("my_future_column7",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;

  @DataColumn("abbreviation",
      metadataLevel: ColumnMetadata.notNull | ColumnMetadata.unique)
  String abbreviation;

  @DataColumn("email", metadataLevel: ColumnMetadata.notNull)
  String email;

  @DataColumn("user_name",
      metadataLevel: ColumnMetadata.notNull | ColumnMetadata.unique)
  String userName;

  @DataColumn("is_current")
  bool isCurrent;
}

```

#### The generated code

From the model, the builder creates `models/user_account.g.m8.dart` file with following content

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2019-05-17 13:54:19.192616

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:sqlite_m8_demo/models/user_account.dart';

class UserAccountProxy extends UserAccount {
  UserAccountProxy({abbreviation, email, userName}) {
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
    map['is_current'] = isCurrent ? 1 : 0;

    return map;
  }

  UserAccountProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.description = map['description'];
    this.abbreviation = map['abbreviation'];
    this.email = map['email'];
    this.userName = map['user_name'];
    this.isCurrent = map['is_current'] == 1 ? true : false;
  }
}

mixin UserAccountDatabaseProvider {
  Future<Database> db;
  final theUserAccountColumns = [
    "id",
    "description",
    "abbreviation",
    "email",
    "user_name",
    "is_current"
  ];

  final String theUserAccountTableHandler = 'user_account';
  Future createUserAccountTable(Database db) async {
    await db.execute('''CREATE TABLE $theUserAccountTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT,
    description TEXT ,
    abbreviation TEXT  NOT NULL,
    email TEXT  NOT NULL,
    user_name TEXT  NOT NULL,
    is_current INTEGER ,
    UNIQUE (id),
    UNIQUE (abbreviation),
    UNIQUE (user_name)
    )''');
  }

  Future<int> saveUserAccount(UserAccountProxy instanceUserAccount) async {
    var dbClient = await db;

    var result = await dbClient.insert(
        theUserAccountTableHandler, instanceUserAccount.toMap());
    return result;
  }

  Future<List<UserAccountProxy>> getUserAccountProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(theUserAccountTableHandler,
        columns: theUserAccountColumns, where: '1');

    return result.map((e) => UserAccountProxy.fromMap(e)).toList();
  }

  Future<int> getUserAccountProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient
        .rawQuery('SELECT COUNT(*) FROM $theUserAccountTableHandler  WHERE 1'));
  }

  Future<UserAccountProxy> getUserAccount(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(theUserAccountTableHandler,
        columns: theUserAccountColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return UserAccountProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteUserAccount(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(theUserAccountTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteUserAccountProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(theUserAccountTableHandler);
    return true;
  }

  Future<int> updateUserAccount(UserAccountProxy instanceUserAccount) async {
    var dbClient = await db;

    return await dbClient.update(
        theUserAccountTableHandler, instanceUserAccount.toMap(),
        where: "id = ?", whereArgs: [instanceUserAccount.id]);
  }

  Future<UserAccountProxy> getCurrentUserAccount() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(theUserAccountTableHandler,
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

    await dbClient.update(theUserAccountTableHandler, map,
        where: "is_current = 1");

    map['is_current'] = 1;
    return await dbClient.update(theUserAccountTableHandler, map,
        where: "1 AND id = ?", whereArgs: [id]);
  }
}
import 'package:f_orm_m8/f_orm_m8.dart';

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
// Emitted on: 2019-05-17 13:54:19.192616

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
    id INTEGER  PRIMARY KEY AUTOINCREMENT,
    diagnosys_date INTEGER ,
    account_id INTEGER  NOT NULL,
    description TEXT  NOT NULL,
    date_create INTEGER,
    date_update INTEGER,
    UNIQUE (id, account_id),
    UNIQUE (account_id, description, account_id)
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

```

### GymLocation - A DbEntity implementation

To demonstrate how to use a generic model, we added a GymLocation model that implements DbEntity. 

![usecase003](example/docs/usecase003-320.gif)

#### The model

The model file `models/gym_location.dart` has the following content:

```dart
import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable(
    "gym_location", TableMetadata.trackCreate | TableMetadata.trackUpdate)
class GymLocation implements DbEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("description", metadataLevel: ColumnMetadata.unique)
  String description;

  @DataColumn("rating")
  int rating;

  @DataColumn("my_future_column7",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;
}

```

#### The generated code

From the model, the builder creates `models/gym_location.g.m8.dart` file with content

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2019-05-17 13:54:19.192616

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:sqlite_m8_demo/models/gym_location.dart';

class GymLocationProxy extends GymLocation {
  DateTime dateCreate;
  DateTime dateUpdate;

  GymLocationProxy();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['description'] = description;
    map['rating'] = rating;
    map['date_create'] = dateCreate.millisecondsSinceEpoch;
    map['date_update'] = dateUpdate.millisecondsSinceEpoch;

    return map;
  }

  GymLocationProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.description = map['description'];
    this.rating = map['rating'];
    this.dateCreate = DateTime.fromMillisecondsSinceEpoch(map['date_create']);
    this.dateUpdate = DateTime.fromMillisecondsSinceEpoch(map['date_update']);
  }
}

mixin GymLocationDatabaseProvider {
  Future<Database> db;
  final theGymLocationColumns = [
    "id",
    "description",
    "rating",
    "date_create",
    "date_update"
  ];

  final String theGymLocationTableHandler = 'gym_location';
  Future createGymLocationTable(Database db) async {
    await db.execute('''CREATE TABLE $theGymLocationTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT,
    description TEXT ,
    rating INTEGER ,
    date_create INTEGER,
    date_update INTEGER,
    UNIQUE (id),
    UNIQUE (description)
    )''');
  }

  Future<int> saveGymLocation(GymLocationProxy instanceGymLocation) async {
    var dbClient = await db;

    instanceGymLocation.dateCreate = DateTime.now();
    instanceGymLocation.dateUpdate = DateTime.now();

    var result = await dbClient.insert(
        theGymLocationTableHandler, instanceGymLocation.toMap());
    return result;
  }

  Future<List<GymLocationProxy>> getGymLocationProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(theGymLocationTableHandler,
        columns: theGymLocationColumns, where: '1');

    return result.map((e) => GymLocationProxy.fromMap(e)).toList();
  }

  Future<int> getGymLocationProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient
        .rawQuery('SELECT COUNT(*) FROM $theGymLocationTableHandler  WHERE 1'));
  }

  Future<GymLocationProxy> getGymLocation(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(theGymLocationTableHandler,
        columns: theGymLocationColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return GymLocationProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteGymLocation(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(theGymLocationTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteGymLocationProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(theGymLocationTableHandler);
    return true;
  }

  Future<int> updateGymLocation(GymLocationProxy instanceGymLocation) async {
    var dbClient = await db;

    instanceGymLocation.dateUpdate = DateTime.now();

    return await dbClient.update(
        theGymLocationTableHandler, instanceGymLocation.toMap(),
        where: "id = ?", whereArgs: [instanceGymLocation.id]);
  }
}


```

### Receipt - A DbEntity implementation

For a more detailed model with all supported fields type, we added a Receipt model that implements DbEntity. 

![usecase004](example/docs/usecase004-320.gif)

#### The model

The model file `models/receipt.dart` has the following content:

```dart
import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("receipt", TableMetadata.trackCreate | TableMetadata.trackUpdate)
class Receipt implements DbEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("number_of_molecules", metadataLevel: ColumnMetadata.notNull)
  BigInt numberOfMolecules;

  @DataColumn("is_bio", metadataLevel: ColumnMetadata.notNull)
  bool isBio;

  @DataColumn("expiration_date", metadataLevel: ColumnMetadata.notNull)
  DateTime expirationDate;

  @DataColumn("quantity", metadataLevel: ColumnMetadata.notNull)
  double quantity;

  @DataColumn("decomposing_duration", metadataLevel: ColumnMetadata.notNull)
  Duration decomposingDuration;

  @DataColumn("number_of_items", metadataLevel: ColumnMetadata.notNull)
  int numberOfItems;

  @DataColumn("storage_temperature", metadataLevel: ColumnMetadata.notNull)
  num storageTemperature;

  @DataColumn("description",
      metadataLevel: ColumnMetadata.unique | ColumnMetadata.notNull)
  String description;

  @DataColumn("my_future_column7",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;
}

```

#### The generated code

From the model, the builder creates `models/receipt.g.m8.dart` file with content

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2019-05-17 13:54:19.192616

// **************************************************************************
// Generator: OrmM8GeneratorForAnnotation
// **************************************************************************

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:sqlite_m8_demo/models/receipt.dart';

class ReceiptProxy extends Receipt {
  DateTime dateCreate;
  DateTime dateUpdate;

  ReceiptProxy(
      {numberOfMolecules,
      isBio,
      expirationDate,
      quantity,
      decomposingDuration,
      numberOfItems,
      storageTemperature,
      description}) {
    this.numberOfMolecules = numberOfMolecules;
    this.isBio = isBio;
    this.expirationDate = expirationDate;
    this.quantity = quantity;
    this.decomposingDuration = decomposingDuration;
    this.numberOfItems = numberOfItems;
    this.storageTemperature = storageTemperature;
    this.description = description;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['number_of_molecules'] = numberOfMolecules.toString();
    map['is_bio'] = isBio ? 1 : 0;
    map['expiration_date'] = expirationDate.millisecondsSinceEpoch;
    map['quantity'] = quantity;
    map['decomposing_duration'] = decomposingDuration.inMilliseconds;
    map['number_of_items'] = numberOfItems;
    map['storage_temperature'] = storageTemperature;
    map['description'] = description;
    map['date_create'] = dateCreate.millisecondsSinceEpoch;
    map['date_update'] = dateUpdate.millisecondsSinceEpoch;

    return map;
  }

  ReceiptProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.numberOfMolecules = BigInt.parse(map['number_of_molecules']);
    this.isBio = map['is_bio'] == 1 ? true : false;
    this.expirationDate =
        DateTime.fromMillisecondsSinceEpoch(map['expiration_date']);
    this.quantity = map['quantity'];
    this.decomposingDuration =
        Duration(milliseconds: map['decomposing_duration']);
    this.numberOfItems = map['number_of_items'];
    this.storageTemperature = map['storage_temperature'];
    this.description = map['description'];
    this.dateCreate = DateTime.fromMillisecondsSinceEpoch(map['date_create']);
    this.dateUpdate = DateTime.fromMillisecondsSinceEpoch(map['date_update']);
  }
}

mixin ReceiptDatabaseProvider {
  Future<Database> db;
  final theReceiptColumns = [
    "id",
    "number_of_molecules",
    "is_bio",
    "expiration_date",
    "quantity",
    "decomposing_duration",
    "number_of_items",
    "storage_temperature",
    "description",
    "date_create",
    "date_update"
  ];

  final String theReceiptTableHandler = 'receipt';
  Future createReceiptTable(Database db) async {
    await db.execute('''CREATE TABLE $theReceiptTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT,
    number_of_molecules TEXT  NOT NULL,
    is_bio INTEGER  NOT NULL,
    expiration_date INTEGER  NOT NULL,
    quantity REAL  NOT NULL,
    decomposing_duration INTEGER  NOT NULL,
    number_of_items INTEGER  NOT NULL,
    storage_temperature NUMERIC  NOT NULL,
    description TEXT  NOT NULL,
    date_create INTEGER,
    date_update INTEGER,
    UNIQUE (id),
    UNIQUE (description)
    )''');
  }

  Future<int> saveReceipt(ReceiptProxy instanceReceipt) async {
    var dbClient = await db;

    instanceReceipt.dateCreate = DateTime.now();
    instanceReceipt.dateUpdate = DateTime.now();

    var result =
        await dbClient.insert(theReceiptTableHandler, instanceReceipt.toMap());
    return result;
  }

  Future<List<ReceiptProxy>> getReceiptProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(theReceiptTableHandler,
        columns: theReceiptColumns, where: '1');

    return result.map((e) => ReceiptProxy.fromMap(e)).toList();
  }

  Future<int> getReceiptProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient
        .rawQuery('SELECT COUNT(*) FROM $theReceiptTableHandler  WHERE 1'));
  }

  Future<ReceiptProxy> getReceipt(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(theReceiptTableHandler,
        columns: theReceiptColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return ReceiptProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteReceipt(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(theReceiptTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteReceiptProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(theReceiptTableHandler);
    return true;
  }

  Future<int> updateReceipt(ReceiptProxy instanceReceipt) async {
    var dbClient = await db;

    instanceReceipt.dateUpdate = DateTime.now();

    return await dbClient.update(
        theReceiptTableHandler, instanceReceipt.toMap(),
        where: "id = ?", whereArgs: [instanceReceipt.id]);
  }
}


```



### The database adapter

For the all models the builder will generate a common database adapter file `main.adapter.g.m8.dart`. The file contains two classes:

- DatabaseAdapter to handle the initialization of the database singleton 
- DatabaseProvider to handle the models CRUD methods

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2019-05-17 13:54:19.192616

// **************************************************************************
// DatabaseProviderGenerator
// **************************************************************************

import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sqlite_m8_demo/models/gym_location.g.m8.dart';
import 'package:sqlite_m8_demo/models/health_entry.g.m8.dart';
import 'package:sqlite_m8_demo/models/receipt.g.m8.dart';
import 'package:sqlite_m8_demo/models/to_do.g.m8.dart';
import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';

enum InitMode { developmentAlwaysReinitDb, testingMockDb, production }

class DatabaseAdapter {
  InitMode _initMode;
  static InitMode _startInitMode;
  static final DatabaseAdapter _instance = DatabaseAdapter._internal();
  static Database _db;

  /// Default initMode is production
  /// [developmentAlwaysReinitDb] then the database will be deleteted on each init
  /// [testingMockDb] then the database will be initialized as mock
  /// [production] then the database will be initialized as production
  factory DatabaseAdapter([InitMode initMode = InitMode.production]) {
    _startInitMode = initMode;
    return _instance;
  }

  DatabaseAdapter._internal() {
    if (_initMode == null) {
      _initMode = _startInitMode;
    }
  }

  InitMode get initMode => _initMode;

  Future<Database> getDb(dynamic _onCreate) async {
    if (_db != null) {
      return _db;
    }
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'm8_store_0.2.0.db');

    if (_startInitMode == InitMode.developmentAlwaysReinitDb) {
      await deleteDatabase(path);
    }

    _db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return _db;
  }
}

class DatabaseProvider
    with
        GymLocationDatabaseProvider,
        HealthEntryDatabaseProvider,
        ReceiptDatabaseProvider,
        ToDoDatabaseProvider,
        UserAccountDatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  static Database _db;

  static DatabaseAdapter _dbBuilder;

  factory DatabaseProvider(DatabaseAdapter dbBuilder) {
    _dbBuilder = dbBuilder;
    return _instance;
  }

  DatabaseProvider._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _dbBuilder.getDb(_onCreate);

    return _db;
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