import 'package:f_orm_m8/f_orm_m8.dart';
import 'package:f_orm_m8_sqlite/generator/core.dart';
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
