import 'package:f_orm_m8/f_orm_m8.dart';
import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';

class EntityAttributeFromBool extends EntityAttribute {
  EntityAttributeFromBool(
      String modelTypeName, String modelName, String attributeName,
      {int metadataLevel, List<CompositeConstraint> compositeConstraints})
      : super(modelTypeName, modelName, attributeName,
            metadataLevel: metadataLevel,
            compositeConstraints: compositeConstraints);

  @override
  String getAttributeTypeDefinition() {
    return "INTEGER";
  }

  @override
  String get modelToEntityMapString {
    return "${modelName} ? 1 : 0";
  }

  @override
  String get entityToModelMapString {
    return "map['${attributeName}'] == 1 ? true : false";
  }
}
