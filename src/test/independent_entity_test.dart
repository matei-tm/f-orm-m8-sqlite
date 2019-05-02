import 'package:flutter_sqlite_m8_generator/generator/core.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_annotation_utils.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() async {
  LibraryReader library;
  final path = testFilePath('test', 'src', 'model');
  EmittedEntity e;

  setUp(() async {
    library =
        await initializeLibraryReaderForDirectory(path, "independent.dart");
    e = getEmittedEntityForAnnotation("my_health_entries_table", library);
  });

  group('Independent entity tests', () {
    test('Test entity name', () {
      expect(e.entityName, "my_health_entries_table");
    });
    test('Test model name', () {
      expect(e.modelName, "HealthEntry");
    });

    test('Test attributes count', () {
      expect(e.attributes.length, 2);
    });

    test('Has attribute id', () {
      var hasId = e.attributes.containsKey("id");
      expect(hasId, true);
    });

    test('Has attribute description', () {
      var hasDescription = e.attributes.containsKey("description");
      expect(hasDescription, true);
    });

    test('Ignored attribute futureData', () {
      var hasFutureData = e.attributes.containsKey("futureData");
      expect(hasFutureData, false);
    });

    test('Entity is soft deletable', () {
      var hasSoftDelete = e.hasSoftDelete;
      expect(hasSoftDelete, true);
    });

    test('Entity is with creation track', () {
      var hasTrackCreate = e.hasTrackCreate;
      expect(hasTrackCreate, true);
    });

    test('Entity is with update track', () {
      var hasTrackUpdate = e.hasTrackUpdate;
      expect(hasTrackUpdate, true);
    });
  });
}
