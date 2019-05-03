import 'dart:io';

import 'package:f_orm_m8_sqlite/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() {
  LibraryReader library;
  final path = testFilePath('test', 'src', 'model');
  final caliber0Path =
      testFilePath('test', 'out', 'no_column_metadata.0.caliber');

  setUp(() async {
    library = await initializeLibraryReaderForDirectory(
        path, "no_column_metadata.dart");
  });

  group('No column metadata tests', () {
    final generator = OrmM8GeneratorForAnnotation();
    test('Test @DataColumn with no ColumnMetadata', () async {
      final output = await generator.generate(library, null);
      final expected = await File(caliber0Path).readAsString();
      expect(output, expected);
    });
  });
}
