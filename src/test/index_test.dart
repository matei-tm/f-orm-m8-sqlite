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

  final path = testFilePath('test', 'src', 'model');
  final caliber1Path = testFilePath('test', 'out', 'index.0.caliber');
  final caliber2Path = testFilePath('test', 'out', 'index.1.caliber');
  final caliber3Path = testFilePath('test', 'out', 'index.2.caliber');
  final caliber4Path = testFilePath('test', 'out', 'index.3.caliber');

  setUp(() async {
    library_1 =
        await initializeLibraryReaderForDirectory(path, "index_probe.0.dart");
    library_2 =
        await initializeLibraryReaderForDirectory(path, "index_probe.1.dart");
    library_3 =
        await initializeLibraryReaderForDirectory(path, "index_probe.2.dart");
    library_4 =
        await initializeLibraryReaderForDirectory(path, "index_probe.3.dart");
  });

  group('Index creation tests', () {
    final generator = OrmM8GeneratorForAnnotation();

    test('Test the named index grouped from two composites', () async {
      await matchProbeOnCaliber(generator, library_1, caliber1Path);
    });

    test('Test the anonymous index from metadataLevel!', () async {
      await matchProbeOnCaliber(generator, library_2, caliber2Path);
    });

    test('Test the combination of indexes from metadataLevel and composites!',
        () async {
      await matchProbeOnCaliber(generator, library_3, caliber3Path);
    });

    test(
        'Test the combination of many indexes from metadataLevel and composites!',
        () async {
      await matchProbeOnCaliber(generator, library_4, caliber4Path);
    });
  });
}
