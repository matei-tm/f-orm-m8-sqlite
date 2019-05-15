import 'package:f_orm_m8_sqlite/generator/utils/entity_attribute.dart';

class AttributeWriter {
  EntityAttribute _entityAttribute;

  AttributeWriter(this._entityAttribute);

  String get modelToEntityMapString => _entityAttribute.modelToEntityMapString;

  String get entityToModelMapString => _entityAttribute.entityToModelMapString;
}
