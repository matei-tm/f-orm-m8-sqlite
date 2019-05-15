import 'package:f_orm_m8_sqlite/generator/utils/entity_attribute.dart';

class AttributeWriter {
  EntityAttribute _entityAttribute;

  AttributeWriter(this._entityAttribute);

  String get modelToEntityMapString =>
      "map['${_entityAttribute.attributeName}'] = ${_entityAttribute.modelToEntityConversionString}";

  String get entityToModelMapString =>
      "this.${_entityAttribute.modelName} = ${_entityAttribute.entityToModelConversionString}";
}
