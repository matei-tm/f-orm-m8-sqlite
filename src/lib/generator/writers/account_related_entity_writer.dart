import 'package:f_orm_m8_sqlite/generator/emitted_entity.dart';
import 'package:f_orm_m8_sqlite/generator/entity_writer.dart';
import 'package:f_orm_m8_sqlite/generator/writers/proxy_writer.dart';

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
${s002}Future<List<${emittedEntity.modelNameProxy}>> get${emittedEntity.modelNameProxyPlural}ByAccountId(int accountId) async {
${s00004}var dbClient = await db;
${s00004}var result = await dbClient.query(${theTableHandler},
${s00004}columns: the${emittedEntity.modelName}Columns,
${s00004}where: '${getAttributeStringAccountId()} = ? AND ${getSoftdeleteCondition()}',
${s00004}whereArgs: [accountId]);

${s00004}return result.map((e) => ${emittedEntity.modelNameProxy}.fromMap(e)).toList();
${s002}}

""");

    sb.write(getSoftdeleteMethod());
    sb.writeln("}");
    return sb.toString();
  }
}
