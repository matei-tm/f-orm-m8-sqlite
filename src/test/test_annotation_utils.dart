import 'package:flutter_orm_m8/flutter_orm_m8.dart';
import 'package:flutter_sqlite_m8_generator/generator/core.dart';
import 'package:source_gen/source_gen.dart';

EmittedEntity getEmittedEntityForAnnotation(
    String testAnnotation, LibraryReader library) {
  var annotatedElement = library
      .annotatedWith(TypeChecker.fromRuntime(DataTable))
      .firstWhere((f) =>
          f.annotation.objectValue.getField('name').toStringValue() ==
          testAnnotation);

  var entityName =
      annotatedElement.annotation.objectValue.getField('name').toStringValue();

  return ModelParser(annotatedElement.element, entityName).getEmittedEntity();
}
