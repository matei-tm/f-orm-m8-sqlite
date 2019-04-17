import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/entity_writer.dart';
import 'package:flutter_sqlite_m8_generator/generator/writers/proxy_writer.dart';

class AccountRelatedEntityWriter extends EntityWriter {
  AccountRelatedEntityWriter(EmittedEntity emittedEntity)
      : super(emittedEntity);

  String getAttributeStringAccountId() {
    return emittedEntity.attributes["accountId"].attributeName;
  }

  @override
  String toString() {
    StringBuffer sb = getCommonImports();

    ProxyWriter proxyWriter = ProxyWriter(emittedEntity);

    sb.write(proxyWriter.toString());

    sb.write(getMixinStart());

    sb.write(getCommonMethods());

    sb.write("""
  Future<List> get${emittedEntity.modelNameProxyPlural}ByAccountId(int accountId) async {
var dbClient = await db;
var result = await dbClient.query(${theTableHandler},
    columns: the${emittedEntity.modelName}Columns,
    where: '${getAttributeStringAccountId()} = ? AND ${getSoftdeleteCondition()}',
    whereArgs: [accountId]);

return result.map((e) => ${emittedEntity.modelNameProxy}.fromMap(e)).toList();
  }

""");

    sb.write(getSoftdeleteMethod());
    sb.writeln("}");
    return sb.toString();
  }
}
