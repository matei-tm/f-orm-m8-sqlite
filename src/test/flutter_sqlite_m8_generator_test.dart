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
      final expected = "Instance of 'EntityWriter'";
      expect(output, expected);
    });
  });
}
