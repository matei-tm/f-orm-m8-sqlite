import 'package:flutter_sqlite_m8_generator/generator/utils/utils.dart';

class EmittedEntity {
  final String modelName;
  final String entityName;
  final EntityType entityType;
  final Map<String, EntityAttribute> attributes;
  final String packageIdentifier;

  EmittedEntity(this.modelName, this.entityName, this.entityType,
      this.attributes, this.packageIdentifier);

  String get modelInstanceName => "instance$modelName";

  // Todo: to find a package like node pluralize
  String get modelPlural => "${modelName}s";
}
