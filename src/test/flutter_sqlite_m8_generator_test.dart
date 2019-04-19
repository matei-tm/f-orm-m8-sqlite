import 'package:flutter_sqlite_m8_generator/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'test_annotation_utils.dart';
import 'test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

LibraryReader _library;

void main() async {
  final path = testFilePath('test', 'src', 'model');
  _library =
      await initializeLibraryReaderForDirectory(path, "account_related.dart");
  group('Generator global tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test raw output', () async {
      final output = await generator.generate(_library, null);
      final expected = r'''import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:__test__/account_related.dart';

class HealthEntryAccountRelatedProxy extends HealthEntryAccountRelated {


  HealthEntryAccountRelatedProxy({accountId}) {
    this.accountId = accountId;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['my_id_column'] = id;
    map['my_description_column'] = description;
    map['my_account_id_column'] = accountId;
    return map;
  }

  HealthEntryAccountRelatedProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['my_id_column'];
    this.description = map['my_description_column'];
    this.accountId = map['my_account_id_column'];
  }
}

mixin HealthEntryAccountRelatedDatabaseHelper {
  Future<Database> db;
  final theHealthEntryAccountRelatedColumns = ["my_id_column", "my_description_column", "my_account_id_column"];

  final String _theHealthEntryAccountRelatedTableHandler = 'my_account_related_table';
  Future createHealthEntryAccountRelatedTable(Database db) async {
await db.execute('CREATE TABLE $_theHealthEntryAccountRelatedTableHandler (my_id_column INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE, my_description_column TEXT  UNIQUE, my_account_id_column INTEGER  NOT NULL)');
  }

  Future<int> saveHealthEntryAccountRelated(HealthEntryAccountRelatedProxy instanceHealthEntryAccountRelated) async {
var dbClient = await db;



var result = await dbClient.insert(_theHealthEntryAccountRelatedTableHandler, instanceHealthEntryAccountRelated.toMap());
return result;
  }

  Future<List<HealthEntryAccountRelated>> getHealthEntryAccountRelatedProxiesAll() async {
var dbClient = await db;
var result =
    await dbClient.query(_theHealthEntryAccountRelatedTableHandler, columns: theHealthEntryAccountRelatedColumns, where: '1');

return result.map((e) => HealthEntryAccountRelatedProxy.fromMap(e)).toList();
  }

  Future<int> getHealthEntryAccountRelatedProxiesCount() async {
var dbClient = await db;
return Sqflite.firstIntValue(
    await dbClient.rawQuery('SELECT COUNT(*) FROM $_theHealthEntryAccountRelatedTableHandler  WHERE 1'));
  }

  Future<HealthEntryAccountRelated> getHealthEntryAccountRelated(int id) async {
var dbClient = await db;
List<Map> result = await dbClient.query(_theHealthEntryAccountRelatedTableHandler,
    columns: theHealthEntryAccountRelatedColumns, where: '1 AND my_id_column = ?', whereArgs: [id]);


if (result.length > 0) {
  return HealthEntryAccountRelatedProxy.fromMap(result.first);
}

return null;
  }

  Future<int> deleteHealthEntryAccountRelated(int id) async {
var dbClient = await db;
return await dbClient
    .delete(_theHealthEntryAccountRelatedTableHandler, where: 'my_id_column = ?', whereArgs: [id]);
  }

  Future<bool> deleteHealthEntryAccountRelatedProxiesAll() async {
var dbClient = await db;
await dbClient.delete(_theHealthEntryAccountRelatedTableHandler);
return true;
  }

  Future<int> updateHealthEntryAccountRelated(HealthEntryAccountRelatedProxy instanceHealthEntryAccountRelated) async {
var dbClient = await db;



return await dbClient.update(_theHealthEntryAccountRelatedTableHandler, instanceHealthEntryAccountRelated.toMap(),
    where: "my_id_column = ?", whereArgs: [instanceHealthEntryAccountRelated.id]);
  }
  Future<List<HealthEntryAccountRelated>> getHealthEntryAccountRelatedProxiesByAccountId(int accountId) async {
var dbClient = await db;
var result = await dbClient.query(_theHealthEntryAccountRelatedTableHandler,
    columns: theHealthEntryAccountRelatedColumns,
    where: 'my_account_id_column = ? AND 1',
    whereArgs: [accountId]);

return result.map((e) => HealthEntryAccountRelatedProxy.fromMap(e)).toList();
  }

}''';
      expect(output, expected);
    });

    test('Missing test annotation', () async {
      expect(
          () => getEmittedEntityForAnnotation(
              "this_test_annotation_does_not_exists", _library),
          throwsA(const TypeMatcher<StateError>()));
    });
  });
}
