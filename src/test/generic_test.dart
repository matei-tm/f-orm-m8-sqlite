import 'dart:io';

import 'package:flutter_sqlite_m8_generator/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_annotation_utils.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() {
  LibraryReader library;
  final path = testFilePath('test', 'src', 'model');
  final caliber0Path = testFilePath('test', 'out', 'account_related.0.caliber');

  setUp(() async {
    library =
        await initializeLibraryReaderForDirectory(path, "account_related.dart");
  });
  group('Generic tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test raw output', () async {
      final output = await generator.generate(library, null);
      final expected = await File(caliber0Path).readAsString();
      expect(output, expected);
    });

    test('Missing test annotation', () async {
      expect(
          () => getEmittedEntityForAnnotation(
              "this_test_annotation_does_not_exists", library),
          throwsA(const TypeMatcher<StateError>()));
    });
  });
}
