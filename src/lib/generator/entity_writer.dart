import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';

class EntityWriter {
  final EmittedEntity emittedEntity;

  EntityWriter(this.emittedEntity) {}

  String get theTableHandler => this.emittedEntity.theTableHandler;

  String get theTableHandlerValue => this.emittedEntity.entityName;

  String get thePrimaryKey => this.emittedEntity.primaryKeyName;

  @override
  String toString() {
    return '/*Not implemented. */';
  }

  String _getColumnsList() {
    return emittedEntity.attributes.values
        .map((f) => f.attributeName)
        .join("\", \"");
  }

  String _getGeneralImports() {
    return """
import 'package:sqflite/sqflite.dart';
import 'dart:async';
/*import 'package:todo_currentProjectPackage_path/abstract_database_helper.dart';*/
import '${emittedEntity.packageIdentifier}';
""";
  }

  String _getMixinHead() {
    return """mixin ${emittedEntity.modelName}DatabaseHelper /*implements AbstractDatabaseHelper*/ {""";
  }

  String _getMixinBodyCommonFields() {
    return """
  Future<Database> db;
  final the${emittedEntity.modelName}Columns = ["${_getColumnsList()}"];

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
      columnList.add("is_deleted INTEGER");
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
}
