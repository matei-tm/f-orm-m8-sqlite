import 'package:flutter_sqlite_m8_generator/generator/utils/entity_attribute.dart';

class AttributeWriter {
  EntityAttribute _entityAttribute;

  AttributeWriter(this._entityAttribute);

  String get modelToEntityMapString =>
      _entityAttribute.modelTypeName == "DateTime"
          ? "${_entityAttribute.modelName}.millisecondsSinceEpoch"
          : _entityAttribute.modelName;

  String get entityToModelMapString => _entityAttribute.modelTypeName ==
          "DateTime"
      ? "DateTime.fromMillisecondsSinceEpoch(map['${_entityAttribute.attributeName}'])"
      : "map['${_entityAttribute.attributeName}']";
}
