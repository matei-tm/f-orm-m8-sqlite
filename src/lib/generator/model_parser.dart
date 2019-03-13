import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

class ModelParser {
  String modelName;
  final ClassElement modelClassElement;
  EntityType entityType;

  ConstantReader reader;

  ModelParser(this.modelClassElement) {
    modelName = this.modelClassElement.name;
  }

  void _extractEntityMeta() {
    /// Guard only DbEntity implementations
    if (!isDbEntity.isAssignableFromType(modelClassElement.type)) {
      throw Exception("Database models must implement `DbEntity` interface!");
    }

    final ElementAnnotation elementAnnotationMetadata =
        modelClassElement.metadata.firstWhere(
            (meta) =>
                isDataTable.isExactlyType(meta.computeConstantValue().type),
            orElse: () => throw Exception(
                "Cannot find or parse `DataTable` annotation!"));

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

  EmittedEntity getEmittedEntity() {
    _extractEntityMeta();

    final resultEntity = EmittedEntity();

    return resultEntity;
  }
}
