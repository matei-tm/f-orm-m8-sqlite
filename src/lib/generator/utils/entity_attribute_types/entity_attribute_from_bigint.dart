import 'package:f_orm_m8/f_orm_m8.dart';
import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';

class EntityAttributeFromBigint extends EntityAttribute {
  EntityAttributeFromBigint(
      String modelTypeName, String modelName, String attributeName,
      {int metadataLevel, List<CompositeConstraint> compositeConstraints})
      : super(modelTypeName, modelName, attributeName,
            metadataLevel: metadataLevel,
            compositeConstraints: compositeConstraints);

  @override
  String getAttributeTypeDefinition() {
    return "TEXT";
  }

  @override
  String get modelToEntityConversionString {
    return "${modelName}.toString()";
  }

  @override
  String get entityToModelConversionString {
    return "BigInt.parse(map['${attributeName}'])";
  }
}
