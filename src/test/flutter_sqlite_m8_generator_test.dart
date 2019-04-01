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
/*import 'package:todo_currentProjectPackage_path/abstract_database_helper.dart';*/
import 'package:__test__/account_related.dart';

mixin HealthEntryAccountRelatedDatabaseHelper /*implements AbstractDatabaseHelper*/ {
  Future<Database> db;
  final theHealthEntryAccountRelatedColumns = ["my_id_column", "my_description_column", "my_account_id_column"];

  final String _theHealthEntryAccountRelatedTableHandler = 'my_account_related_table';

  Future createHealthEntryAccountRelatedTable(Database db) async {
await db.execute('CREATE TABLE $_theHealthEntryAccountRelatedTableHandler (my_id_column INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE, my_description_column TEXT  UNIQUE, my_account_id_column INTEGER  NOT NULL)');
  }

  Future<int> saveHealthEntryAccountRelated(HealthEntryAccountRelated instanceHealthEntryAccountRelated) async {
var dbClient = await db;
var result = await dbClient.insert(_theHealthEntryAccountRelatedTableHandler, instanceHealthEntryAccountRelated.toMap());
return result;
  }

  Future<List> getHealthEntryAccountRelatedsAll() async {
var dbClient = await db;
var result =
    await dbClient.query(_theHealthEntryAccountRelatedTableHandler, columns: theHealthEntryAccountRelatedColumns, where: 'is_deleted != 1');

return result.toList();
  }

  Future<List> getHealthEntryAccountRelatedsByAccountId(int accountId) async {
var dbClient = await db;
var result = await dbClient.query(_theHealthEntryAccountRelatedTableHandler,
    columns: theHealthEntryAccountRelatedColumns,
    where: 'account_id = ? AND is_deleted != 1',
    whereArgs: [accountId]);

return result.toList();
  }

  Future<int> getHealthEntryAccountRelatedsCount() async {
var dbClient = await db;
return Sqflite.firstIntValue(
    await dbClient.rawQuery('SELECT COUNT(*) FROM $_theHealthEntryAccountRelatedTableHandler  WHERE is_deleted != 1'));
  }

  Future<HealthEntryAccountRelated> getHealthEntryAccountRelated(int id) async {
var dbClient = await db;
List<Map> result = await dbClient.query(_theHealthEntryAccountRelatedTableHandler,
    columns: theHealthEntryAccountRelatedColumns, where: 'my_id_column = ?  AND is_deleted != 1', whereArgs: [id]);

/*
if (result.length > 0) {
  return HealthEntryAccountRelated.fromMap(result.first);
}
*/

return null;
  }

  Future<int> deleteHealthEntryAccountRelated(int id) async {
var dbClient = await db;
return await dbClient
    .delete(_theHealthEntryAccountRelatedTableHandler, where: 'my_id_column = ?', whereArgs: [id]);
  }

  Future<bool> deleteHealthEntryAccountRelatedsAll() async {
var dbClient = await db;
await dbClient.delete(_theHealthEntryAccountRelatedTableHandler);
return true;
  }

  Future<int> updateHealthEntryAccountRelated(HealthEntryAccountRelated instanceHealthEntryAccountRelated) async {
var dbClient = await db;
return await dbClient.update(_theHealthEntryAccountRelatedTableHandler, instanceHealthEntryAccountRelated.toMap(),
    where: "my_id_column = ?", whereArgs: [instanceHealthEntryAccountRelated.id]);
  }

  Future<int> softdeleteHealthEntryAccountRelated(int id) async {
var dbClient = await db;

var map = Map<String, dynamic>();
map['is_deleted'] = 1;

return await dbClient
    .update(_theHealthEntryAccountRelatedTableHandler, map, where: "my_id_column = ?", whereArgs: [id]);
  }
}


//    Entity:my_account_related_table Model:HealthEntryAccountRelated
//{_id: Instance of 'EntityAttribute', _description: Instance of 'EntityAttribute', _accountId: Instance of 'EntityAttribute'}''';
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
