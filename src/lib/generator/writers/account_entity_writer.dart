import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/entity_writer.dart';
import 'package:flutter_sqlite_m8_generator/generator/writers/proxy_writer.dart';

class AccountEntityWriter extends EntityWriter {
  AccountEntityWriter(EmittedEntity emittedEntity) : super(emittedEntity);

  String getAttributeStringIsCurrent() {
    return "is_current";
  }

  @override
  String toString() {
    StringBuffer sb = getCommonImports();

    ProxyWriter proxyWriter = ProxyWriter(emittedEntity);

    sb.write(proxyWriter.toString());

    sb.write(getMixinStart());

    sb.write(getCommonMethods());

    sb.write("""
  Future<${emittedEntity.modelName}> getCurrent${emittedEntity.modelName}() async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(${theTableHandler},
        columns: the${emittedEntity.modelName}Columns, where: '${getSoftdeleteCondition()} AND ${getAttributeStringIsCurrent()} = 1');

    if (result.length > 0) {
      return ${emittedEntity.modelNameProxy}.fromMap(result.first);
    }

    return null;
  }

  Future<int> setCurrent${emittedEntity.modelName}(int id) async {
    var dbClient = await db;

    var map = Map<String, dynamic>();
    map['${getAttributeStringIsCurrent()}'] = 0;

    await dbClient.update(${theTableHandler}, map,
        where: "${getAttributeStringIsCurrent()} = 1");

    map['${getAttributeStringIsCurrent()}'] = 1;
    return await dbClient.update(${theTableHandler}, map,
        where: "${getSoftdeleteCondition()} AND id = ?", whereArgs: [id]);
  }

""");

    sb.write(getSoftdeleteMethod());
    sb.writeln("}");
    return sb.toString();
  }
}
