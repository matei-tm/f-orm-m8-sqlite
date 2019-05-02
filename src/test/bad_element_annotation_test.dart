import 'package:flutter_sqlite_m8_generator/orm_m8_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() {
  LibraryReader library;
  final path = testFilePath('test', 'src', 'model');

  setUp(() async {
    library =
        await initializeLibraryReaderForDirectory(path, "bad_element.dart");
  });

  group('Bad element annotation tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test @DataTable on wrong element', () async {
      String v = await generator.generate(library, null);
      expect(v.substring(0, 89),
          '''/*\nException: @DataTable annotation must be defined on a class. \'int croco\' is misplaced\n''');
    });
  });
}
