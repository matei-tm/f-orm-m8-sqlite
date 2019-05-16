import 'package:f_orm_m8_sqlite/generator/writers/sql_definition_writer.dart';

class EntityWriter extends SqlDefinitionWriter {
  EntityWriter(emittedEntity) : super(emittedEntity);

  String get thePrimaryKey => this.emittedEntity.primaryKeyName;

  @override
  String toString() {
    return '/*Not implemented. */';
  }

  List<String> _getColumnsList() {
    var columnList =
        emittedEntity.attributes.values.map((f) => f.attributeName).toList();

    if (emittedEntity.hasTrackCreate) {
      columnList.add("date_create");
    }

    if (emittedEntity.hasTrackUpdate) {
      columnList.add("date_update");
    }

    if (emittedEntity.hasSoftDelete) {
      columnList.add("date_delete");
    }

    return columnList;
  }

  String _getColumnsListString() {
    return _getColumnsList().join("\",\n    \"");
  }

  String _getGeneralImports() {
    return """
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '${emittedEntity.packageIdentifier}';
""";
  }

  String _getMixinHead() {
    return """mixin ${emittedEntity.modelName}DatabaseProvider {""";
  }

  String _getMixinBodyCommonFields() {
    return """
${s002}Future<Database> db;
${s002}final the${emittedEntity.modelName}Columns = [\n    "${_getColumnsListString()}"\n  ];

${s002}final String ${theTableHandler} = '${theTableHandlerValue}';""";
  }

  StringBuffer getCommonImports() {
    StringBuffer sb = StringBuffer();

    sb.writeln(_getGeneralImports());

    return sb;
  }

  String getMixinStart() {
    StringBuffer sb = StringBuffer();

    sb.writeln(_getMixinHead());
    sb.writeln(_getMixinBodyCommonFields());

    return sb.toString();
  }

  String getMixinEnd() {
    StringBuffer sb = StringBuffer();

    sb.writeln("}");

    return sb.toString();
  }

  String getCreateTrackableTimestampString() {
    String trackableTimestamp = '';
    if (emittedEntity.hasTrackCreate) {
      trackableTimestamp =
          "instance${emittedEntity.modelName}.dateCreate = DateTime.now();";
    }

    if (emittedEntity.hasTrackUpdate) {
      trackableTimestamp +=
          "\n${s00004}instance${emittedEntity.modelName}.dateUpdate = DateTime.now();";
    }

    return trackableTimestamp;
  }

  String getUpdateTrackableTimestampString() {
    if (emittedEntity.hasTrackUpdate) {
      return "instance${emittedEntity.modelName}.dateUpdate = DateTime.now();";
    }

    return "";
  }

  String getSoftdeleteCondition() {
    if (emittedEntity.hasSoftDelete) {
      return 'date_delete > 0';
    }

    return '1'; // return a valid SQL expression
  }

  String getSoftdeleteMethod() {
    if (emittedEntity.hasSoftDelete) {
      return '''
${s002}Future<int> softdelete${emittedEntity.modelName}(int id) async {
${s00004}var dbClient = await db;

${s00004}var map = Map<String, dynamic>();
${s00004}map['date_delete'] = DateTime.now().millisecondsSinceEpoch;

${s00004}return await dbClient
${s00004}.update(${theTableHandler}, map, where: "$thePrimaryKey = ?", whereArgs: [id]);
${s002}}
''';
    }

    return '';
  }

  String getCommonMethods() {
    return '''
${s002}Future create${emittedEntity.modelName}Table(Database db) async {
${s00004}${getTableFullDefinitionBlock()}${getIndexStringBlock()}
${s002}}

${s002}Future<int> save${emittedEntity.modelName}(${emittedEntity.modelNameProxy} ${emittedEntity.modelInstanceName}) async {
${s00004}var dbClient = await db;

${s00004}${getCreateTrackableTimestampString()}

${s00004}var result = await dbClient.insert(${theTableHandler}, ${emittedEntity.modelInstanceName}.toMap());
${s00004}return result;
${s002}}

${s002}Future<List<${emittedEntity.modelNameProxy}>> get${emittedEntity.modelNameProxyPlural}All() async {
${s00004}var dbClient = await db;
${s00004}var result =
${s00000008}await dbClient.query(${theTableHandler}, columns: the${emittedEntity.modelName}Columns, where: '${getSoftdeleteCondition()}');

${s00004}return result.map((e) => ${emittedEntity.modelNameProxy}.fromMap(e)).toList();
${s002}}

${s002}Future<int> get${emittedEntity.modelNameProxyPlural}Count() async {
${s00004}var dbClient = await db;
${s00004}return Sqflite.firstIntValue(
${s00004}await dbClient.rawQuery('SELECT COUNT(*) FROM \$${theTableHandler}  WHERE ${getSoftdeleteCondition()}'));
${s002}}

${s002}Future<${emittedEntity.modelNameProxy}> get${emittedEntity.modelName}(int id) async {
${s00004}var dbClient = await db;
${s00004}List<Map> result = await dbClient.query(${theTableHandler},
${s00004}${s00004}columns: the${emittedEntity.modelName}Columns, where: '${getSoftdeleteCondition()} AND $thePrimaryKey = ?', whereArgs: [id]);


${s00004}if (result.length > 0) {
${s00004}${s002}return ${emittedEntity.modelNameProxy}.fromMap(result.first);
${s00004}}

${s00004}return null;
${s002}}

${s002}Future<int> delete${emittedEntity.modelName}(int id) async {
${s00004}var dbClient = await db;
${s00004}return await dbClient
${s00004}${s00004}.delete(${theTableHandler}, where: '$thePrimaryKey = ?', whereArgs: [id]);
${s002}}

${s002}Future<bool> delete${emittedEntity.modelNameProxyPlural}All() async {
${s00004}var dbClient = await db;
${s00004}await dbClient.delete(${theTableHandler});
${s00004}return true;
${s002}}

${s002}Future<int> update${emittedEntity.modelName}(${emittedEntity.modelNameProxy} ${emittedEntity.modelInstanceName}) async {
${s00004}var dbClient = await db;

${getUpdateTrackableTimestampString()}

${s00004}return await dbClient.update(${theTableHandler}, ${emittedEntity.modelInstanceName}.toMap(),
${s00004}${s00004}where: "$thePrimaryKey = ?", whereArgs: [${emittedEntity.modelInstanceName}.id]);
${s002}}
''';
  }
}
