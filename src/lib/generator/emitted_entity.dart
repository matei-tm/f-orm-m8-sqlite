import 'package:flutter_sqlite_m8_generator/generator/utils/utils.dart';

class EmittedEntity {
  final String modelName;
  final String entityName;
  final Map<String, EntityAttribute> attributes;
  EmittedEntity(this.modelName, this.entityName, this.attributes);
}
