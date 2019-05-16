import 'dart:io';

import 'package:f_orm_m8_sqlite/generator/core.dart';
import 'package:f_orm_m8_sqlite/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_annotation_utils.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() async {
  LibraryReader library;
  final path = testFilePath('test', 'src', 'model');
  final caliber0Path = testFilePath('test', 'out', 'open.0.caliber');

  EmittedEntity e;

  setUp(() async {
    library = await initializeLibraryReaderForDirectory(path, "open.dart");
    e = getEmittedEntityForAnnotation("my_health_entries_table", library);
  });

  group('Open entity raw output test', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test raw output', () async {
      final output = await generator.generate(library, null);
      final expected = await File(caliber0Path).readAsString();
      expect(output, expected);
    });
  });

  group('Open entity tests', () {
    test('Test entity name', () {
      expect(e.entityName, "my_health_entries_table");
    });
    test('Test model name', () {
      expect(e.modelName, "HealthEntry");
    });

    test('Test attributes count', () {
      expect(e.attributes.length, 3);
    });

    test('Has attribute pkPart1', () {
      var hasId = e.attributes.containsKey("pkPart1");
      expect(hasId, true);
    });
    test('Has attribute pkPart2', () {
      var hasId = e.attributes.containsKey("pkPart2");
      expect(hasId, true);
    });

    test('Has attribute description', () {
      var hasDescription = e.attributes.containsKey("description");
      expect(hasDescription, true);
    });
  });
}
