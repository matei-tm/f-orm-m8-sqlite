import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:flutter_sqlite_m8_generator/exceptions/field_parse_exception.dart';
import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

class ModelParser {
  String modelName;
  EntityType entityType;
  ConstantReader reader;
  int entityMetadataLevel;

  String get packageIdentifier => modelClassElement.library.identifier;

  final ClassElement modelClassElement;
  final String entityName;

  final Map<String, EntityAttribute> entityAttributes =
      <String, EntityAttribute>{};

  ModelParser(this.modelClassElement, this.entityName) {
    modelName = this.modelClassElement.name;
  }

  EmittedEntity getEmittedEntity() {
    _extractEntityMeta();
    _extractEntityAttributes();

    final EmittedEntity resultEntity = EmittedEntity(modelName, entityName,
        entityType, entityMetadataLevel, entityAttributes, packageIdentifier);

    return resultEntity;
  }

  void _extractEntityMeta() {
    if (!isDbEntity.isAssignableFromType(modelClassElement.type)) {
      throw Exception("Database models must implement `DbEntity` interface!");
    }

    final ElementAnnotation elementAnnotationMetadata =
        modelClassElement.metadata.firstWhere(
            (meta) =>
                isDataTable.isExactlyType(meta.computeConstantValue().type),
            orElse: () => throw Exception(
                "The DbEntity implementations must be annotated with `@DataTable`!"));

    entityMetadataLevel = modelClassElement.metadata
            .map((ElementAnnotation annot) => annot.computeConstantValue())
            .where((DartObject d) => isDataTable.isExactlyType(d.type))
            .map((DartObject obj) => obj.getField('metadataLevel').toIntValue())
            .first ??
        0;

    reader = ConstantReader(elementAnnotationMetadata.computeConstantValue());

    if (modelClassElement.allSupertypes
        .any((InterfaceType i) => isDbAccountEntity.isExactlyType(i))) {
      entityType = EntityType.account;
    } else if (modelClassElement.allSupertypes
        .any((InterfaceType i) => isDbAccountRelatedEntity.isExactlyType(i))) {
      entityType = EntityType.accountRelated;
    } else if (modelClassElement.allSupertypes
        .any((InterfaceType i) => isDbEntity.isExactlyType(i))) {
      entityType = EntityType.independent;
    }
  }

  void _extractEntityAttributes() {
    modelClassElement.fields.forEach((f) {
      _parseModelField(f);
    });
  }

  void _parseModelField(FieldElement field) {
    try {
      if (field.displayName == 'hashCode' ||
          field.displayName == 'runtimeType' ||
          field.isStatic ||
          field.getter == null) return;
      //todo final or synthetic

      var valuesList = field.metadata
          .map((ElementAnnotation annot) => annot.computeConstantValue())
          .toList();

      List<EntityAttribute> rawEntityAttributes = valuesList
          .where((DartObject d) => isDataColumn.isExactlyType(d.type))
          .map((DartObject obj) => EntityAttribute(
              field.type.name, field.name, obj.getField('name').toStringValue(),
              metadataLevel: obj.getField('metadataLevel').toIntValue() ?? 0))
          .toList();

      if (rawEntityAttributes.length > 1) {
        throw Exception('Only one Column annotation is allowed on a Field!');
      }

      if (rawEntityAttributes.isEmpty) return;

      var firstField = rawEntityAttributes.first;

      if (mustIgnore(firstField.metadataLevel)) return;

      if (firstField is EntityAttribute) {
        entityAttributes[firstField.modelName] = firstField;
      }
    } catch (exception, stack) {
      throw FieldParseException(field.name, exception, stack);
    }
  }
}
