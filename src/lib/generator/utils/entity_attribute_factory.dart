import 'package:f_orm_m8/f_orm_m8.dart';
import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';

class EntityAttributeFactory {
  //todo inject config by database type

  EntityAttribute extractEntityAttribute(
      FieldElement field, DartObject dataColumnAnnotation) {
    String modelTypeName = field.type.name;
    String modelName = field.name;

    String attributeName =
        dataColumnAnnotation.getField('name').toStringValue();
    var metadataLevel =
        dataColumnAnnotation.getField('metadataLevel').toIntValue() ?? 0;
    var comp;
    comp = getCompositeConstraints(dataColumnAnnotation);

    if (isBool.isExactlyType(field.type))
      return EntityAttributeFromBool(modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
    else if (isDouble.isExactlyType(field.type))
      return EntityAttributeFromDouble(modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
    else if (isInt.isExactlyType(field.type))
      return EntityAttributeFromInt(modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
    else if (isNum.isExactlyType(field.type))
      return EntityAttributeFromNum(modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
    else if (isDateTime.isExactlyType(field.type))
      return EntityAttributeFromDateTime(
          modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
    else if (isString.isExactlyType(field.type))
      return EntityAttributeFromString(modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
    else if (isBigInt.isExactlyType(field.type))
      return EntityAttributeFromBigint(modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
    else if (isDuration.isExactlyType(field.type))
      return EntityAttributeFromDuration(
          modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
    else if (isList.isExactlyType(field.type)) // todo
      return EntityAttributeFromNotImplemented(
          modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
    else if (isMap.isExactlyType(field.type)) // todo
      return EntityAttributeFromNotImplemented(
          modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
    else
      return EntityAttributeFromNotImplemented(
          modelTypeName, modelName, attributeName,
          metadataLevel: metadataLevel, compositeConstraints: comp);
  }

  List<CompositeConstraint> getCompositeConstraints(
      DartObject dataColumnAnnotation) {
    List<CompositeConstraint> compositeConstraints = dataColumnAnnotation
        ?.getField('compositeConstraints')
        ?.toListValue()
        ?.map((s) => CompositeConstraint(
            name: s.getField('name').toString(),
            constraintType: CompositeConstraintType.values.firstWhere((t) =>
                t.toString().split('.')[1] ==
                s
                    .getField('constraintType')
                    .toString()
                    .split(' ')[1]
                    .replaceFirst('(', ''))))
        ?.toList();
    return compositeConstraints;
  }
}
