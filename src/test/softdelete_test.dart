import 'dart:io';

import 'package:flutter_sqlite_m8_generator/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() {
  LibraryReader library;
  final probesPath = testFilePath('test', 'src', 'model');
  final caliber0Path = testFilePath('test', 'out', 'softdelete.0.caliber');

  setUp(() async {
    library = await initializeLibraryReaderForDirectory(
        probesPath, "softdelete_probe.dart");
  });
  group('Softdelete tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test raw output', () async {
      final output = await generator.generate(library, null);
      final expected = await File(caliber0Path).readAsString();
      expect(output, expected);
    });
  });
}
