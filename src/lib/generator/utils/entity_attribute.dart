import 'package:flutter_sqlite_m8_generator/generator/utils/attribute_metadata_parser.dart';
import 'package:flutter_sqlite_m8_generator/generator/utils/type_mapper.dart';

class EntityAttribute {
  final String modelTypeName;
  final String modelName;

  final String attributeName;

  final int metadataLevel;

  EntityAttribute(this.modelTypeName, this.modelName, this.attributeName,
      {this.metadataLevel});

  String getMetadataAsDefinition() {
    return AttributeMetadataParser.getDefinition(metadataLevel);
  }

  String getAttributeTypeDefinition() {
    return TypeMapper.getTypeDefinition(modelTypeName);
  }

  String getAttributeFullDefinition() {
    return "${attributeName} ${getAttributeTypeDefinition()} ${getMetadataAsDefinition()}";
  }
}
