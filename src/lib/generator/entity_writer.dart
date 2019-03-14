import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/utils/utils.dart';

class EntityWriter {
  String currentProjectPackage;
  String theTableHandler;
  final EmittedEntity emittedEntity;

  EntityWriter(this.emittedEntity) {
    theTableHandler = "_the${this.emittedEntity.modelName}TableHandler";
    currentProjectPackage = '';
  }

  @override
  String toString() {
    switch (this.emittedEntity.entityType) {
      case EntityType.accountRelated:
        return getAccountRelatedString();
        break;
      case EntityType.account:
        return getAccountString();
        break;
      case EntityType.independent:
        return getIndependentString();
        break;
      default:
        return '/* Invalid model. */';
    }
  }

  String getAccountRelatedString() {
    StringBuffer sb = StringBuffer();

    //sb.writeln('/*');

    sb.write("""
import 'package:sqflite/sqflite.dart';
import 'dart:async';
/*import 'package:${currentProjectPackage}/helpers/database/abstract_database_helper.dart';*/

mixin ${emittedEntity.modelName}DatabaseHelper /*implements AbstractDatabaseHelper*/ {
  Future<Database> db;
  final String columnId = 'id';
  final the${emittedEntity.modelName}Columns = ["id", "account_id", "record_date", "is_deleted" /*, "entry_name"*/];

  final String ${theTableHandler} = 'emittedEntity.entityName';

  Future create${emittedEntity.modelName}Table(Database db) async {
await db.execute(
    'CREATE TABLE \$${theTableHandler} (\$columnId INTEGER PRIMARY KEY, account_id INTEGER, record_date INTEGER, is_deleted INTEGER )');
  }

  Future<int> save${emittedEntity.modelName}(${emittedEntity.modelName} ${emittedEntity.modelInstanceName}) async {
var dbClient = await db;
var result = await dbClient.insert(${theTableHandler}, ${emittedEntity.modelInstanceName}.toMap());
return result;
  }

  Future<List> get${emittedEntity.modelPlural}All() async {
var dbClient = await db;
var result =
    await dbClient.query(${theTableHandler}, columns: the${emittedEntity.modelName}Columns, where: 'is_deleted != 1');

return result.toList();
  }

  Future<List> get${emittedEntity.modelPlural}ByAccountId(int accountId) async {
var dbClient = await db;
var result = await dbClient.query(${theTableHandler},
    columns: the${emittedEntity.modelName}Columns,
    where: 'account_id = ? AND is_deleted != 1',
    whereArgs: [accountId]);

return result.toList();
  }

  Future<int> get${emittedEntity.modelPlural}Count() async {
var dbClient = await db;
return Sqflite.firstIntValue(
    await dbClient.rawQuery('SELECT COUNT(*) FROM \$${theTableHandler}  WHERE is_deleted != 1'));
  }

  Future<${emittedEntity.modelName}> get${emittedEntity.modelName}(int id) async {
var dbClient = await db;
List<Map> result = await dbClient.query(${theTableHandler},
    columns: the${emittedEntity.modelName}Columns, where: '\$columnId = ?  AND is_deleted != 1', whereArgs: [id]);

/*
if (result.length > 0) {
  return ${emittedEntity.modelName}.fromMap(result.first);
}
*/

return null;
  }

  Future<int> delete${emittedEntity.modelName}(int id) async {
var dbClient = await db;
return await dbClient
    .delete(${theTableHandler}, where: '\$columnId = ?', whereArgs: [id]);
  }

  Future<bool> delete${emittedEntity.modelPlural}All() async {
var dbClient = await db;
await dbClient.delete(${theTableHandler});
return true;
  }

  Future<int> update${emittedEntity.modelName}(${emittedEntity.modelName} ${emittedEntity.modelInstanceName}) async {
var dbClient = await db;
return await dbClient.update(${theTableHandler}, ${emittedEntity.modelInstanceName}.toMap(),
    where: "\$columnId = ?", whereArgs: [${emittedEntity.modelInstanceName}.id]);
  }

  Future<int> softdelete${emittedEntity.modelName}(int id) async {
var dbClient = await db;

var map = Map<String, dynamic>();
map['is_deleted'] = 1;

return await dbClient
    .update(${theTableHandler}, map, where: "\$columnId = ?", whereArgs: [id]);
  }
}


//    Entity:${emittedEntity.entityName} Model:${emittedEntity.modelName}\n//${emittedEntity.attributes.toString()}
    
                        """);
    //sb.writeln('*/');

    return sb.toString();
  }

  String getAccountString() {
    return '/*Not implemented*/';
  }

  String getIndependentString() {
    return '/*Not implemented*/';
  }
}
