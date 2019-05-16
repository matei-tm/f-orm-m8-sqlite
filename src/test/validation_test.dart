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
  LibraryReader library_6;
  LibraryReader library_7;

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
  final caliber6Path = testFilePath('test', 'out', 'multiple_pk.0.caliber');
  final caliber7Path = testFilePath('test', 'out', 'multiple_pk.0.caliber');

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
    library_6 = await initializeLibraryReaderForDirectory(
        path, "bad_multiple_pk_probe.0.dart");
    library_7 = await initializeLibraryReaderForDirectory(
        path, "bad_multiple_pk_probe.1.dart");
  });

  group('Validation tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test the multiple DataColumn annotations on the same field!',
        () async {
      await matchProbeOnCaliber(generator, library_1, caliber1Path);
    });

    test('Test the not Implemented validations field!', () async {
      await matchProbeOnCaliber(generator, library_2, caliber2Path);
    });

    test('Test validation of a model without annotated fields!', () async {
      await matchProbeOnCaliber(generator, library_3, caliber3Path);
    });

    test('Test validation of a model with custom type fields!', () async {
      await matchProbeOnCaliber(generator, library_4, caliber4Path);
    });

    test(
        'Test validation Database models must implement DbEntity or DbOpenEntity',
        () async {
      await matchProbeOnCaliber(generator, library_5, caliber5Path);
    });

    test('Test validation multiple composite groups, PKs on the same model',
        () async {
      await matchProbeOnCaliber(generator, library_6, caliber6Path);
    });

    test(
        'Test validation multiple, composite and single, PKs on the same model',
        () async {
      await matchProbeOnCaliber(generator, library_7, caliber7Path);
    });
  });
}

Future matchProbeOnCaliber(OrmM8GeneratorForAnnotation generator,
    LibraryReader library, String caliberPath) async {
  String output = await generator.generate(library, null);

  final expected = await File(caliberPath).readAsString();
  expect(output, expected);
}
