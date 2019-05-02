# Sqlite ORM Mate Generator (flutter-sqlite-m8-generator)

![GitHub release](https://img.shields.io/github/release-pre/matei-tm/flutter-sqlite-m8-generator.svg) [![pub package](https://img.shields.io/pub/v/flutter_sqlite_m8_generator.svg)](https://pub.dartlang.org/packages/flutter_sqlite_m8_generator) [![Build Status](https://travis-ci.org/matei-tm/flutter-sqlite-m8-generator.svg?branch=master)](https://travis-ci.org/matei-tm/flutter-sqlite-m8-generator) [![license](https://img.shields.io/github/license/matei-tm/flutter-sqlite-m8-generator.svg)](https://github.com/matei-tm/flutter-sqlite-m8-generator/blob/master/LICENSE)

- [Sqlite ORM Mate Generator (flutter-sqlite-m8-generator)](#sqlite-orm-mate-generator-flutter-sqlite-m8-generator)
  - [Introduction](#introduction)
  - [Dependencies](#dependencies)
  - [Usage](#usage)
  - [Example - Gymspector application](#example---gymspector-application)
    - [UserAccount - A DbAccountEntity implementation](#useraccount---a-dbaccountentity-implementation)
      - [The model](#the-model)
      - [The generated code](#the-generated-code)
    - [HealthEntry - A DbAccountRelatedEntity implementation](#healthentry---a-dbaccountrelatedentity-implementation)
      - [The model](#the-model-1)
      - [The generated code](#the-generated-code-1)
    - [GymLocation - A DbEntity implementation](#gymlocation---a-dbentity-implementation)
      - [The model](#the-model-2)
      - [The generated code](#the-generated-code-2)
    - [Receipt - A DbEntity implementation](#receipt---a-dbentity-implementation)
      - [The model](#the-model-3)
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
| ColumnMetadata.      | indexed                | ColumnMetadata      | -                 | Planned for v0.6.0 |
| CompositeConstraint. | unique                 | CompositeConstraint | v0.4.0            |                    |
| CompositeConstraint. | primaryKey             | CompositeConstraint | v0.4.0            |                    |
| CompositeConstraint. | foreignKey             | CompositeConstraint | -                 | Planned for v0.6.0 |
| CompositeConstraint. | indexed                | CompositeConstraint | -                 | Planned for v0.6.0 |
| implements           | DbOpenEntity           | entity helper       | -                 | Planned for v0.6.0 |
| implements           | DbEntity               | entity helper       | v0.1.0            |                    |
| implements           | DbAccountEntity        | entity helper       | v0.1.0            |                    |
| implements           | DbAccountRelatedEntity | entity helper       | v0.1.0            |                    |


## Usage

1. Create a flutter project
2. Add f_orm_m8, sqflite, build_runner, flutter_sqlite_m8_generator dependencies to `pubspec.yaml`

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
            flutter_sqlite_m8_generator: ^0.4.0
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
7. Using [f_orm_m8](https://github.com/matei-tm/f-orm-m8) annotations convention mark:

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

## Example - Gymspector application

A full, flutter working example is maintained on [https://github.com/matei-tm/flutter-sqlite-m8-generator/tree/master/example](https://github.com/matei-tm/flutter-sqlite-m8-generator/tree/master/example).  
The example presents different approaches to solve CRUD functionality for models that adhere to f_orm_m8 annotation framework.

![usecase000](https://github.com/matei-tm/flutter-sqlite-m8-generator/blob/master/example/docs/usecase000-320.gif)


### UserAccount - A DbAccountEntity implementation

The example has a common UserAccount model that implements DbAccountEntity

![usecase001](https://github.com/matei-tm/flutter-sqlite-m8-generator/blob/master/example/docs/usecase001-320.gif)

#### The model

The model file `models/user_account.dart` has the following content:

```dart
import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("user_account")
class UserAccount implements DbAccountEntity {
  @DataColumn(
      "id",
      ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("description")
  String description;

  @DataColumn(
      "my_future_column7", ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;

  @DataColumn("abbreviation", ColumnMetadata.notNull | ColumnMetadata.unique)
  String abbreviation;

  @DataColumn("email", ColumnMetadata.notNull)
  String email;

  @DataColumn("user_name", ColumnMetadata.notNull | ColumnMetadata.unique)
  String userName;

  @DataColumn("is_current")
  bool isCurrent;
}
```

#### The generated code

From the model, the builder creates `models/user_account.g.m8.dart` file with following content

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

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
    await db.execute('''CREATE TABLE $_theUserAccountTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE,
    description TEXT ,
    abbreviation TEXT  NOT NULL UNIQUE,
    email TEXT  NOT NULL,
    user_name TEXT  NOT NULL UNIQUE,
    is_current INTEGER         
)''');
  }

  Future<int> saveUserAccount(UserAccountProxy instanceUserAccount) async {
    var dbClient = await db;

    var result = await dbClient.insert(
        _theUserAccountTableHandler, instanceUserAccount.toMap());
    return result;
  }

  Future<List<UserAccount>> getUserAccountProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(_theUserAccountTableHandler,
        columns: theUserAccountColumns, where: '1');

    return result.map((e) => UserAccountProxy.fromMap(e)).toList();
  }

  Future<int> getUserAccountProxiesCount() async {
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

  Future<bool> deleteUserAccountProxiesAll() async {
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
}

```

### HealthEntry - A DbAccountRelatedEntity implementation

To demonstrate how to use a model that is dependent to UserAccount, we added HealthEntry model that implements DbAccountRelatedEntity.
The model detain a composite unique constraint based on accountId and description.

![usecase002](https://github.com/matei-tm/flutter-sqlite-m8-generator/blob/master/example/docs/usecase002-320.gif)

#### The model

The model file `models/health_entry.dart` has the following content:

```dart
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

To demonstrate how to use a generic model, we added a GymLocation model that implements DbEntity. 

![usecase003](https://github.com/matei-tm/flutter-sqlite-m8-generator/blob/master/example/docs/usecase003-320.gif)

#### The model

The model file `models/gym_location.dart` has the following content:

```dart
import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable(
    "gym_location", TableMetadata.trackCreate | TableMetadata.trackUpdate)
class GymLocation implements DbEntity {
  @DataColumn(
      "id",
      ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("description", ColumnMetadata.unique)
  String description;

  @DataColumn("rating")
  int rating;

  @DataColumn(
      "my_future_column7", ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;
}
```

#### The generated code

From the model, the builder creates `models/gym_location.g.m8.dart` file with content

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

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

mixin GymLocationDatabaseHelper {
  Future<Database> db;
  final theGymLocationColumns = [
    "id",
    "description",
    "rating",
    "date_create",
    "date_update"
  ];

  final String _theGymLocationTableHandler = 'gym_location';
  Future createGymLocationTable(Database db) async {
    await db.execute('''CREATE TABLE $_theGymLocationTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE,
    description TEXT  UNIQUE,
    rating INTEGER ,
    date_create INTEGER,
    date_update INTEGER        
)''');
  }

  Future<int> saveGymLocation(GymLocationProxy instanceGymLocation) async {
    var dbClient = await db;

    instanceGymLocation.dateCreate = DateTime.now();
    instanceGymLocation.dateUpdate = DateTime.now();

    var result = await dbClient.insert(
        _theGymLocationTableHandler, instanceGymLocation.toMap());
    return result;
  }

  Future<List<GymLocation>> getGymLocationProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(_theGymLocationTableHandler,
        columns: theGymLocationColumns, where: '1');

    return result.map((e) => GymLocationProxy.fromMap(e)).toList();
  }

  Future<int> getGymLocationProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT COUNT(*) FROM $_theGymLocationTableHandler  WHERE 1'));
  }

  Future<GymLocation> getGymLocation(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(_theGymLocationTableHandler,
        columns: theGymLocationColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return GymLocationProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteGymLocation(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(_theGymLocationTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteGymLocationProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(_theGymLocationTableHandler);
    return true;
  }

  Future<int> updateGymLocation(GymLocationProxy instanceGymLocation) async {
    var dbClient = await db;

    instanceGymLocation.dateUpdate = DateTime.now();

    return await dbClient.update(
        _theGymLocationTableHandler, instanceGymLocation.toMap(),
        where: "id = ?", whereArgs: [instanceGymLocation.id]);
  }
}
```

### Receipt - A DbEntity implementation

For a more detailed model with all supported fields type, we added a Receipt model that implements DbEntity. 

![usecase004](https://github.com/matei-tm/flutter-sqlite-m8-generator/blob/master/example/docs/usecase004-320.gif)

#### The model

The model file `models/receipt.dart` has the following content:

```dart
import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("receipt", TableMetadata.trackCreate | TableMetadata.trackUpdate)
class Receipt implements DbEntity {
  @DataColumn(
      "id",
      ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("is_bio", ColumnMetadata.notNull)
  bool isBio;

  @DataColumn("expiration_date", ColumnMetadata.notNull)
  DateTime expirationDate;

  @DataColumn("price", ColumnMetadata.notNull)
  double quantity;

  @DataColumn("number_of_items", ColumnMetadata.notNull)
  int numberOfItems;

  @DataColumn("storage_temperature", ColumnMetadata.notNull)
  num storageTemperature;

  @DataColumn("description", ColumnMetadata.unique | ColumnMetadata.notNull)
  String description;

  @DataColumn(
      "my_future_column7", ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;
}
```

#### The generated code

From the model, the builder creates `models/receipt.g.m8.dart` file with content

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

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
      {isBio,
      expirationDate,
      quantity,
      numberOfItems,
      storageTemperature,
      description}) {
    this.isBio = isBio;
    this.expirationDate = expirationDate;
    this.quantity = quantity;
    this.numberOfItems = numberOfItems;
    this.storageTemperature = storageTemperature;
    this.description = description;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['is_bio'] = isBio ? 1 : 0;
    map['expiration_date'] = expirationDate.millisecondsSinceEpoch;
    map['price'] = quantity;
    map['number_of_items'] = numberOfItems;
    map['storage_temperature'] = storageTemperature;
    map['description'] = description;
    map['date_create'] = dateCreate.millisecondsSinceEpoch;
    map['date_update'] = dateUpdate.millisecondsSinceEpoch;

    return map;
  }

  ReceiptProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.isBio = map['is_bio'] == 1 ? true : false;
    this.expirationDate =
        DateTime.fromMillisecondsSinceEpoch(map['expiration_date']);
    this.quantity = map['price'];
    this.numberOfItems = map['number_of_items'];
    this.storageTemperature = map['storage_temperature'];
    this.description = map['description'];
    this.dateCreate = DateTime.fromMillisecondsSinceEpoch(map['date_create']);
    this.dateUpdate = DateTime.fromMillisecondsSinceEpoch(map['date_update']);
  }
}

mixin ReceiptDatabaseHelper {
  Future<Database> db;
  final theReceiptColumns = [
    "id",
    "is_bio",
    "expiration_date",
    "price",
    "number_of_items",
    "storage_temperature",
    "description",
    "date_create",
    "date_update"
  ];

  final String _theReceiptTableHandler = 'receipt';
  Future createReceiptTable(Database db) async {
    await db.execute('''CREATE TABLE $_theReceiptTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE,
    is_bio INTEGER  NOT NULL,
    expiration_date INTEGER  NOT NULL,
    price REAL  NOT NULL,
    number_of_items INTEGER  NOT NULL,
    storage_temperature NUMERIC  NOT NULL,
    description TEXT  NOT NULL UNIQUE,
    date_create INTEGER,
    date_update INTEGER        
)''');
  }

  Future<int> saveReceipt(ReceiptProxy instanceReceipt) async {
    var dbClient = await db;

    instanceReceipt.dateCreate = DateTime.now();
    instanceReceipt.dateUpdate = DateTime.now();

    var result =
        await dbClient.insert(_theReceiptTableHandler, instanceReceipt.toMap());
    return result;
  }

  Future<List<Receipt>> getReceiptProxiesAll() async {
    var dbClient = await db;
    var result = await dbClient.query(_theReceiptTableHandler,
        columns: theReceiptColumns, where: '1');

    return result.map((e) => ReceiptProxy.fromMap(e)).toList();
  }

  Future<int> getReceiptProxiesCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient
        .rawQuery('SELECT COUNT(*) FROM $_theReceiptTableHandler  WHERE 1'));
  }

  Future<Receipt> getReceipt(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(_theReceiptTableHandler,
        columns: theReceiptColumns, where: '1 AND id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return ReceiptProxy.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteReceipt(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(_theReceiptTableHandler, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> deleteReceiptProxiesAll() async {
    var dbClient = await db;
    await dbClient.delete(_theReceiptTableHandler);
    return true;
  }

  Future<int> updateReceipt(ReceiptProxy instanceReceipt) async {
    var dbClient = await db;

    instanceReceipt.dateUpdate = DateTime.now();

    return await dbClient.update(
        _theReceiptTableHandler, instanceReceipt.toMap(),
        where: "id = ?", whereArgs: [instanceReceipt.id]);
  }
}
```

### The database adapter

For the all models the builder will generate a common database adapter file `main.adapter.g.m8.dart`

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DatabaseHelperGenerator
// **************************************************************************

import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sqlite_m8_demo/models/gym_location.g.m8.dart';
import 'package:sqlite_m8_demo/models/health_entry.g.m8.dart';
import 'package:sqlite_m8_demo/models/receipt.g.m8.dart';
import 'package:sqlite_m8_demo/models/to_do.g.m8.dart';
import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';

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