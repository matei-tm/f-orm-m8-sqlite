// GENERATED CODE - DO NOT MODIFY BY HAND
// Emitted on: 2019-05-12 22:58:06.362172

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
