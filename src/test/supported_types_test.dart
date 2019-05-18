import 'dart:io';

import 'package:f_orm_m8_sqlite/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() async {
  LibraryReader library0;
  LibraryReader library1;
  final path = testFilePath('test', 'src', 'model');
  final caliber0Path = testFilePath('test', 'out', 'supported_types.0.caliber');
  final caliber1Path = testFilePath('test', 'out', 'supported_types.1.caliber');

  setUp(() async {
    library0 = await initializeLibraryReaderForDirectory(
        path, "supported_types_probe.0.dart");
    library1 = await initializeLibraryReaderForDirectory(
        path, "supported_types_probe.1.dart");
  });

  group('Supported types test', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Already implemented types', () async {
      final output = await generator.generate(library0, null);
      final expected = await File(caliber0Path).readAsString();
      expect(output, expected);
    });

    test('Not implemented types', () async {
      final output = await generator.generate(library1, null);
      final expected = await File(caliber1Path).readAsString();
      expect(output, expected);
    });
  });
}
