import 'package:flutter_sqlite_m8_generator/generator/writers/entity_writer_factory.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'test_annotation_utils.dart';
import 'test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() {
  LibraryReader library;
  final path = testFilePath('test', 'src', 'model');
  var e;
  var entityWriter;
  
  setUp(() async {
    library = await initializeLibraryReaderForDirectory(
        path, "account_related_composite.dart");
    e = getEmittedEntityForAnnotation("my_account_related_table", library);
    entityWriter = EntityWriterFactory().getWriter(e);
  });

  group('Account related composite entity tests', () {
    test('Test entity name', () {
      expect(e.entityName, "my_account_related_table");
    });
    test('Test model name', () {
      expect(e.modelName, "HealthEntryAccountRelated");
    });

    test('Test attributes count', () {
      expect(e.attributes.length, 3);
    });

    test('Has attribute id', () {
      var hasId = e.attributes.containsKey("id");
      expect(hasId, true);
    });

    test('Has attribute description', () {
      var hasDescription = e.attributes.containsKey("description");
      expect(hasDescription, true);
    });

    test('Ignored attribute futureData', () {
      var hasFutureData = e.attributes.containsKey("futureData");
      expect(hasFutureData, false);
    });

    test('Has attribute accountId', () {
      var hasAttribute = e.attributes.containsKey("accountId");
      expect(hasAttribute, true);
    });

    test('Entity is not soft deletable', () {
      var hasSoftDelete = e.hasSoftDelete;
      expect(hasSoftDelete, false);
    });

    test('Entity is not with creation track', () {
      var hasTrackCreate = e.hasTrackCreate;
      expect(hasTrackCreate, false);
    });

    test('Entity is not with update track', () {
      var hasTrackUpdate = e.hasTrackUpdate;
      expect(hasTrackUpdate, false);
    });

    test('Test raw output', () {
      var output = entityWriter.toString();
      var expected = r"""import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:__test__/account_related_composite.dart';

class HealthEntryAccountRelatedProxy extends HealthEntryAccountRelated {


  HealthEntryAccountRelatedProxy();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['my_id_column'] = id;
    map['account_id'] = accountId;
    map['description'] = description;
    return map;
  }

  HealthEntryAccountRelatedProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['my_id_column'];
    this.accountId = map['account_id'];
    this.description = map['description'];
  }
}

mixin HealthEntryAccountRelatedDatabaseHelper {
  Future<Database> db;
  final theHealthEntryAccountRelatedColumns = ["my_id_column", "account_id", "description"];

  final String _theHealthEntryAccountRelatedTableHandler = 'my_account_related_table';
  Future createHealthEntryAccountRelatedTable(Database db) async {
await db.execute('''CREATE TABLE $_theHealthEntryAccountRelatedTableHandler (
    my_id_column INTEGER  PRIMARY KEY AUTOINCREMENT UNIQUE,
    account_id INTEGER ,
    description TEXT     ,
    UNIQUE(account_id, description)
)''');
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
    where: 'account_id = ? AND 1',
    whereArgs: [accountId]);

return result.map((e) => HealthEntryAccountRelatedProxy.fromMap(e)).toList();
  }

}
""";
      expect(output, expected);
    });
  });
}
