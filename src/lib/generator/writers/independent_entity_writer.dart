import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/entity_writer.dart';

class IndependentEntityWriter extends EntityWriter {
  IndependentEntityWriter(EmittedEntity emittedEntity) : super(emittedEntity);

  @override
  String toString() {
    StringBuffer sb = getCommonStart();

    sb.write("""
  
  Future create${emittedEntity.modelName}Table(Database db) async {
await db.execute(
    'CREATE TABLE \$${theTableHandler} (\$primaryKeyHandler INTEGER PRIMARY KEY, record_date INTEGER, is_deleted INTEGER )');
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

  Future<int> get${emittedEntity.modelPlural}Count() async {
var dbClient = await db;
return Sqflite.firstIntValue(
    await dbClient.rawQuery('SELECT COUNT(*) FROM \$${theTableHandler}  WHERE is_deleted != 1'));
  }

  Future<${emittedEntity.modelName}> get${emittedEntity.modelName}(int id) async {
var dbClient = await db;
List<Map> result = await dbClient.query(${theTableHandler},
    columns: the${emittedEntity.modelName}Columns, where: '\$primaryKeyHandler = ?  AND is_deleted != 1', whereArgs: [id]);

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
    .delete(${theTableHandler}, where: '\$primaryKeyHandler = ?', whereArgs: [id]);
  }

  Future<bool> delete${emittedEntity.modelPlural}All() async {
var dbClient = await db;
await dbClient.delete(${theTableHandler});
return true;
  }

  Future<int> update${emittedEntity.modelName}(${emittedEntity.modelName} ${emittedEntity.modelInstanceName}) async {
var dbClient = await db;
return await dbClient.update(${theTableHandler}, ${emittedEntity.modelInstanceName}.toMap(),
    where: "\$primaryKeyHandler = ?", whereArgs: [${emittedEntity.modelInstanceName}.id]);
  }

  Future<int> softdelete${emittedEntity.modelName}(int id) async {
var dbClient = await db;

var map = Map<String, dynamic>();
map['is_deleted'] = 1;

return await dbClient
    .update(${theTableHandler}, map, where: "\$primaryKeyHandler = ?", whereArgs: [id]);
  }
}


//    Entity:${emittedEntity.entityName} Model:${emittedEntity.modelName}\n//${emittedEntity.attributes.toString()}
    
                        """);
    //sb.writeln('*/');

    return sb.toString();
  }
}
