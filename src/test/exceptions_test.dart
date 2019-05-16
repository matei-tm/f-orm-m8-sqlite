import 'package:f_orm_m8_sqlite/exceptions/field_parse_exception.dart';
import 'package:f_orm_m8_sqlite/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() {
  LibraryReader library_2;
  final path = testFilePath('test', 'src', 'model');

  setUp(() async {
    library_2 = await initializeLibraryReaderForDirectory(
        path, "bad_no_datatable_annotation_probe.dart");
  });

  group('Exceptions tests', () {
    final generator = OrmM8GeneratorForAnnotation();
    test(
        'Test the DbEntity implementations must be annotated with `@DataTable`!',
        () async {
      String v = await generator.generate(library_2, null);

      expect(
          v.contains(
              '''/*\nException: The DbEntity implementations must be annotated with `@DataTable`!'''),
          true);
    });

    test('Test FieldParseException', () async {
      expect(
          () =>
              simulateFieldParseException(), // throwsA(TypeMatcher<FieldParseException>()))
          throwsA(allOf(
              TypeMatcher<FieldParseException>(),
              predicate((e) =>
                  e.message == 'Just test' &&
                  e.toString().contains(
                      'Exception while parsing field "testField" on "TestModel"!')))));
    });
  });
}

void simulateFieldParseException() async {
  try {
    throw Exception("FieldParseException test");
  } catch (exception, stack) {
    throw FieldParseException("testField", "TestModel",
        inner: exception, trace: stack, message: "Just test");
  }
}
