import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';

class EntityWriter {
  final EmittedEntity emittedEntity;

  EntityWriter(this.emittedEntity);

  String get theTableHandler => this.emittedEntity.theTableHandler;

  String get theTableHandlerValue => this.emittedEntity.entityName;

  String get thePrimaryKey => this.emittedEntity.primaryKeyName;

  @override
  String toString() {
    return '/*Not implemented. */';
  }

  List<String> _getColumnsList() {
    var columnList =
        emittedEntity.attributes.values.map((f) => f.attributeName).toList();

    if (emittedEntity.hasSoftDelete) {
      columnList.add("is_deleted");
    }

    if (emittedEntity.hasTrackCreate) {
      columnList.add("date_create");
    }

    if (emittedEntity.hasTrackUpdate) {
      columnList.add("date_update");
    }

    return columnList;
  }

  String _getColumnsListString() {
    return _getColumnsList().join("\", \"");
  }

  String _getGeneralImports() {
    return """
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '${emittedEntity.packageIdentifier}';
""";
  }

  String _getMixinHead() {
    return """mixin ${emittedEntity.modelName}DatabaseHelper {""";
  }

  String _getMixinBodyCommonFields() {
    return """
  Future<Database> db;
  final the${emittedEntity.modelName}Columns = ["${_getColumnsListString()}"];

  final String ${theTableHandler} = '${theTableHandlerValue}';""";
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

  String getTableDefinition() {
    List<String> columnList = List<String>();

    emittedEntity.attributes
        .forEach((k, v) => columnList.add("${v.getAttributeFullDefinition()}"));

    if (emittedEntity.hasSoftDelete) {
      columnList.add("is_deleted INTEGER DEFAULT 0");
    }

    if (emittedEntity.hasTrackCreate) {
      columnList.add("date_create INTEGER");
    }

    if (emittedEntity.hasTrackUpdate) {
      columnList.add("date_update INTEGER");
    }

    String tableDefinition =
        "'CREATE TABLE \$${theTableHandler} (${columnList.join(", ")})'";

    return tableDefinition;
  }

  String getCreateTrackableTimestampString() {
    String trackableTimestamp = '';
    if (emittedEntity.hasTrackCreate) {
      trackableTimestamp = "instanceHealthEntry.dateCreate = DateTime.now();";
    }

    if (emittedEntity.hasTrackUpdate) {
      trackableTimestamp +=
          "\ninstanceHealthEntry.dateUpdate = DateTime.now();";
    }

    return trackableTimestamp;
  }

  String getUpdateTrackableTimestampString() {
    if (emittedEntity.hasTrackUpdate) {
      return "instanceHealthEntry.dateUpdate = DateTime.now();";
    }

    return "";
  }

  String getSoftdeleteCondition() {
    if (emittedEntity.hasSoftDelete) {
      return 'is_deleted != 1';
    }

    return '1'; // return a valid SQL expression
  }

  String getSoftdeleteMethod() {
    if (emittedEntity.hasSoftDelete) {
      return '''
  Future<int> softdelete${emittedEntity.modelName}(int id) async {
var dbClient = await db;

var map = Map<String, dynamic>();
map['is_deleted'] = 1;

return await dbClient
    .update(${theTableHandler}, map, where: "$thePrimaryKey = ?", whereArgs: [id]);
  }''';
    }

    return '';
  }
}
