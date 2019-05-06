import 'package:f_orm_m8_sqlite/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() {
  LibraryReader library_1;
  LibraryReader library_2;
  LibraryReader library_3;
  final path = testFilePath('test', 'src', 'model');

  setUp(() async {
    library_1 = await initializeLibraryReaderForDirectory(
        path, "bad_nondbentity_probe.dart");
    library_2 = await initializeLibraryReaderForDirectory(
        path, "bad_no_datatable_annotation_probe.dart");
    library_3 = await initializeLibraryReaderForDirectory(
        path, "bad_multiple_datacolumns_on_field_test.dart");
  });

  group('Exceptions tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test Database models must implement DbEntity', () async {
      String v = await generator.generate(library_1, null);

      expect(
          v.contains(
              '''/*\nException: Database models must implement `DbEntity` interface!'''),
          true);
    });

    test(
        'Test the DbEntity implementations must be annotated with `@DataTable`!',
        () async {
      String v = await generator.generate(library_2, null);

      expect(
          v.contains(
              '''/*\nException: The DbEntity implementations must be annotated with `@DataTable`!'''),
          true);
    });

    test('Test the multiple DataColumn annotations on the same field!',
        () async {
      String v = await generator.generate(library_3, null);

      expect(
          v.contains(
              '''/*\nException while parsing field: description!\nException: Only one Column annotation is allowed on a Field!'''),
          true);
    });
  });
}
