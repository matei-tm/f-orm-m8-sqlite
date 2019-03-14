import 'package:flutter_sqlite_m8_generator/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'test_annotation_utils.dart';
import 'test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

LibraryReader _library;

void main() async {
  final path = testFilePath('test', 'src', 'model');
  _library =
      await initializeLibraryReaderForDirectory(path, "account_related.dart");
  group('Generator global tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test raw output', () async {
      final output = await generator.generate(_library, null);
      final expected = r'''/*
Instance of 'EntityWriter'
Entity:my_account_related_table Model:HealthEntryAccountRelated
{_id: Instance of 'EntityAttribute', _description: Instance of 'EntityAttribute', _account_id: Instance of 'EntityAttribute'}*/''';
      expect(output, expected);
    });

    test('Missing test annotation', () async {
      expect(
          () => getEmittedEntityForAnnotation(
              "this_test_annotation_does_not_exists", _library),
          throwsA(const TypeMatcher<StateError>()));
    });
  });
}
