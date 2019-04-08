import 'package:flutter_sqlite_m8_generator/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

LibraryReader _library;

void main() async {
  final path = testFilePath('test', 'src', 'model');
  _library =
      await initializeLibraryReaderForDirectory(path, "no_column_metadata.dart");
  group('Generator global tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test @DataColumn with no ColumnMetadata', () async {
      String v = await generator.generate(_library, null);
      expect(v,
          '''import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:__test__/no_column_metadata.dart';

class AModelWithoutExplicitColumnMetadataProxy extends AModelWithoutExplicitColumnMetadata {
  AModelWithoutExplicitColumnMetadataProxy();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['my_id_column'] = id;
    map['my_description_column'] = description;
    map['my_future_column'] = futureData;
    return map;
  }

  AModelWithoutExplicitColumnMetadataProxy.fromMap(Map<String, dynamic> map) {
    this.id = map['my_id_column'];
    this.description = map['my_description_column'];
    this.futureData = map['my_future_column'];
  }
}

mixin AModelWithoutExplicitColumnMetadataDatabaseHelper {
  Future<Database> db;
  final theAModelWithoutExplicitColumnMetadataColumns = ["my_id_column", "my_description_column", "my_future_column"];

  final String _theAModelWithoutExplicitColumnMetadataTableHandler = 'my_account_related_table';
  
  Future createAModelWithoutExplicitColumnMetadataTable(Database db) async {
await db.execute('CREATE TABLE \$_theAModelWithoutExplicitColumnMetadataTableHandler (my_id_column INTEGER , my_description_column TEXT , my_future_column INTEGER )');
  }

  Future<int> saveAModelWithoutExplicitColumnMetadata(AModelWithoutExplicitColumnMetadataProxy instanceAModelWithoutExplicitColumnMetadata) async {
var dbClient = await db;
var result = await dbClient.insert(_theAModelWithoutExplicitColumnMetadataTableHandler, instanceAModelWithoutExplicitColumnMetadata.toMap());
return result;
  }

  Future<List> getAModelWithoutExplicitColumnMetadatasAll() async {
var dbClient = await db;
var result =
    await dbClient.query(_theAModelWithoutExplicitColumnMetadataTableHandler, columns: theAModelWithoutExplicitColumnMetadataColumns, where: '1');

return result.toList();
  }

  Future<int> getAModelWithoutExplicitColumnMetadatasCount() async {
var dbClient = await db;
return Sqflite.firstIntValue(
    await dbClient.rawQuery('SELECT COUNT(*) FROM \$_theAModelWithoutExplicitColumnMetadataTableHandler  WHERE 1'));
  }

  Future<AModelWithoutExplicitColumnMetadata> getAModelWithoutExplicitColumnMetadata(int id) async {
var dbClient = await db;
List<Map> result = await dbClient.query(_theAModelWithoutExplicitColumnMetadataTableHandler,
    columns: theAModelWithoutExplicitColumnMetadataColumns, where: '1 AND null = ?', whereArgs: [id]);


if (result.length > 0) {
  return AModelWithoutExplicitColumnMetadataProxy.fromMap(result.first);
}

return null;
  }

  Future<int> deleteAModelWithoutExplicitColumnMetadata(int id) async {
var dbClient = await db;
return await dbClient
    .delete(_theAModelWithoutExplicitColumnMetadataTableHandler, where: 'null = ?', whereArgs: [id]);
  }

  Future<bool> deleteAModelWithoutExplicitColumnMetadatasAll() async {
var dbClient = await db;
await dbClient.delete(_theAModelWithoutExplicitColumnMetadataTableHandler);
return true;
  }

  Future<int> updateAModelWithoutExplicitColumnMetadata(AModelWithoutExplicitColumnMetadataProxy instanceAModelWithoutExplicitColumnMetadata) async {
var dbClient = await db;
return await dbClient.update(_theAModelWithoutExplicitColumnMetadataTableHandler, instanceAModelWithoutExplicitColumnMetadata.toMap(),
    where: "null = ?", whereArgs: [instanceAModelWithoutExplicitColumnMetadata.id]);
  }
}''');
    });
  });
}
