import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';

class EmittedEntity {
  final String modelName;
  final String entityName;
  final EntityType entityType;
  final Map<String, EntityAttribute> attributes;
  final String packageIdentifier;
  final int entityMetadataLevel;

  String get theTableHandler => "the${modelName}TableHandler";
  bool get hasSoftDelete => isSoftDeletable(entityMetadataLevel);
  bool get hasTrackCreate => isCreateTrackable(entityMetadataLevel);
  bool get hasTrackUpdate => isUpdateTrackable(entityMetadataLevel);

  EmittedEntity(this.modelName, this.entityName, this.entityType,
      this.entityMetadataLevel, this.attributes, this.packageIdentifier);

  String get modelInstanceName => "instance$modelName";

  String get modelNameProxyPlural => "${modelName}Proxies";

  String get modelNameProxy => "${modelName}Proxy";

  get primaryKeyName => getPrimaryKeyName();

  getPrimaryKeyName() {
    String primaryKeyName;

    attributes.forEach((k, v) {
      if (isPrimaryKey(v.metadataLevel)) primaryKeyName = v.attributeName;
    });

    return primaryKeyName;
  }
}
