// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2019-05-15 00:33:16.415844

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
    map['quantity'] = quantity;
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
    this.quantity = map['quantity'];
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
    "quantity",
    "number_of_items",
    "storage_temperature",
    "description",
    "date_create",
    "date_update"
  ];

  final String theReceiptTableHandler = 'receipt';
  Future createReceiptTable(Database db) async {
    await db.execute('''CREATE TABLE $theReceiptTableHandler (
    id INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE,
    is_bio INTEGER  NOT NULL,
    expiration_date INTEGER  NOT NULL,
    quantity REAL  NOT NULL,
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
