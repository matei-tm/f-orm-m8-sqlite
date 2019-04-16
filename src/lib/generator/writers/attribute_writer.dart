import 'package:flutter_sqlite_m8_generator/generator/utils/entity_attribute.dart';

class AttributeWriter {
  EntityAttribute _entityAttribute;

  AttributeWriter(this._entityAttribute);

  String get modelToEntityMapString {
    switch (_entityAttribute.modelTypeName) {
      case "DateTime":
        return "${_entityAttribute.modelName}.millisecondsSinceEpoch";
        break;
      case "bool":
        return "${_entityAttribute.modelName} ? 1 : 0";
        break;
      default:
        return _entityAttribute.modelName;
    }
  }

  String get entityToModelMapString {
    switch (_entityAttribute.modelTypeName) {
      case "DateTime":
        return "DateTime.fromMillisecondsSinceEpoch(map['${_entityAttribute.attributeName}'])";
        break;
      case "bool":
        return "map['${_entityAttribute.attributeName}'] == 1 ? true : false";
        break;
      default:
        return "map['${_entityAttribute.attributeName}']";
    }
  }
}
