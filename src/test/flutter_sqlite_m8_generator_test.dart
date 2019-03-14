import 'package:flutter_orm_m8/flutter_orm_m8.dart';
import 'package:flutter_sqlite_m8_generator/generator/core.dart';
import 'package:flutter_sqlite_m8_generator/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'analysis_utils.dart';
import 'test_file_utils.dart';

LibraryReader _library;

void main() async {
  final path = testFilePath('test', 'src', 'model');
  _library = await resolveCompilationUnit(path, "a");
  group('All tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test healthy annotations', () async {
      final output = await generator.generate(_library, null);
      final expected = "/*\nInstance of 'EntityWriter'\n*/";
      expect(output, expected);
    });

    test('Missing test annotation', () async {
      expect(
          () => getEmittedEntityForAnnotation(
              "this_test_annotation_does_not_exists"),
          throwsA(const TypeMatcher<StateError>()));
    });

    test('OK test annotation', () async {
      var e = getEmittedEntityForAnnotation("my_health_entries_table");
      expect(e.entityName, "my_health_entries_table");
    });
  });
}

EmittedEntity getEmittedEntityForAnnotation(String testAnnotation) {
  var annotatedElement = _library
      .annotatedWith(TypeChecker.fromRuntime(DataTable))
      .firstWhere((f) =>
          f.annotation.objectValue.getField('name').toStringValue() ==
          testAnnotation);

  var entityName =
      annotatedElement.annotation.objectValue.getField('name').toStringValue();

  return ModelParser(annotatedElement.element, entityName).getEmittedEntity();
}
