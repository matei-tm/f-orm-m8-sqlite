import 'package:f_orm_m8/f_orm_m8.dart';
import 'package:f_orm_m8_sqlite/generator/utils/attribute_metadata_parser.dart';
import 'package:f_orm_m8_sqlite/generator/utils/type_mapper.dart';

abstract class EntityAttribute {
  final String modelTypeName;
  final String modelName;

  final String attributeName;

  final int metadataLevel;

  final List<CompositeConstraint> compositeConstraints;

  EntityAttribute(this.modelTypeName, this.modelName, this.attributeName,
      {this.metadataLevel, this.compositeConstraints});

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
