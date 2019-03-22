import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';

class EntityWriter {
  final EmittedEntity emittedEntity;

  EntityWriter(this.emittedEntity) {}

  String get theTableHandler =>
      "_the${this.emittedEntity.modelName}TableHandler";

  String get theTableHandlerValue => "${this.emittedEntity.entityName}";

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

  final String ${theTableHandler} = '${theTableHandlerValue}';

  final String primaryKeyHandler = 'id';""";
  }

  StringBuffer getCommonStart() {
    StringBuffer sb = StringBuffer();
    sb.writeln(_getGeneralImports());
    sb.writeln(_getMixinHead());
    sb.writeln(_getMixinBodyCommonFields());

    return sb;
  }
}
