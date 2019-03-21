import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';

class EntityWriter {
  final EmittedEntity emittedEntity;

  EntityWriter(this.emittedEntity) {}

  String get theTableHandler =>
      "_the${this.emittedEntity.modelName}TableHandler";

  String get theTableHandlerValue => "${this.emittedEntity.entityName}";

  String get currentProjectPackage => 'Unknown';

  @override
  String toString() {
    return '/*Not implemented. */';
  }

  String getColumnsList() {
    return emittedEntity.attributes.keys.join(""",""");
  }
}
