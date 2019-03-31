import 'package:flutter_sqlite_m8_generator/generator/utils/utils.dart';

class EmittedEntity {
  final String modelName;
  final String entityName;
  final EntityType entityType;
  final Map<String, EntityAttribute> attributes;
  final String packageIdentifier;

  String get theTableHandler => "_the${modelName}TableHandler";

  EmittedEntity(this.modelName, this.entityName, this.entityType,
      this.attributes, this.packageIdentifier);

  String get modelInstanceName => "instance$modelName";

  // Todo: to find a package like node pluralize
  String get modelPlural => "${modelName}s";

  get primaryKeyName => getPrimaryKeyName();

  String getTableDefinition() {
    List<String> columnList = List<String>();

    attributes
        .forEach((k, v) => columnList.add("${v.getAttributeFullDefinition()}"));

    String tableDefinition =
        "'CREATE TABLE \$${theTableHandler} (${columnList.join(", ")})'";
    //  "'CREATE TABLE \$${theTableHandler} (\$primaryKeyHandler INTEGER PRIMARY KEY NOT NULL, record_date INTEGER, is_deleted INTEGER )'";
    return tableDefinition;
  }

  getPrimaryKeyName() {
    String primaryKeyName;

    attributes.forEach((k, v) {
      if (isPrimaryKey(v.metadataLevel)) primaryKeyName = v.attributeName;
    });

    return primaryKeyName;
  }
}
