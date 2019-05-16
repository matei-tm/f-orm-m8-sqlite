import 'dart:io';

import 'package:f_orm_m8_sqlite/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() {
  LibraryReader library_1;
  LibraryReader library_2;
  LibraryReader library_3;
  LibraryReader library_4;
  LibraryReader library_5;

  final path = testFilePath('test', 'src', 'model');
  final caliber1Path =
      testFilePath('test', 'out', 'multiple_datacolumn_on_field.0.caliber');
  final caliber2Path =
      testFilePath('test', 'out', 'type_checker_validation.0.caliber');
  final caliber3Path = testFilePath('test', 'out', 'no_fields.0.caliber');
  final caliber4Path =
      testFilePath('test', 'out', 'custom_type_field.0.caliber');
  final caliber5Path =
      testFilePath('test', 'out', 'non_dbentity_or_dbopenentity.0.caliber');

  setUp(() async {
    library_1 = await initializeLibraryReaderForDirectory(
        path, "bad_multiple_datacolumns_on_field.dart");
    library_2 = await initializeLibraryReaderForDirectory(
        path, "type_checkers_probe.dart");
    library_3 =
        await initializeLibraryReaderForDirectory(path, "no_fields_probe.dart");
    library_4 = await initializeLibraryReaderForDirectory(
        path, "custom_type_field_probe.dart");
    library_5 = await initializeLibraryReaderForDirectory(
        path, "not_allowed_entity_probe.dart");
  });

  group('Validation tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test the multiple DataColumn annotations on the same field!',
        () async {
      String output = await generator.generate(library_1, null);

      final expected = await File(caliber1Path).readAsString();
      expect(output, expected);
    });

    test('Test the not Implemented validations field!', () async {
      String output = await generator.generate(library_2, null);

      final expected = await File(caliber2Path).readAsString();
      expect(output, expected);
    });

    test('Test validation of a model without annotated fields!', () async {
      String output = await generator.generate(library_3, null);

      final expected = await File(caliber3Path).readAsString();
      expect(output, expected);
    });

    test('Test validation of a model with custom type fields!', () async {
      String output = await generator.generate(library_4, null);

      final expected = await File(caliber4Path).readAsString();
      expect(output, expected);
    });

    test(
        'Test validation Database models must implement DbEntity or DbOpenEntity',
        () async {
      String output = await generator.generate(library_5, null);

      final expected = await File(caliber5Path).readAsString();
      expect(output, expected);
    });
  });
}
