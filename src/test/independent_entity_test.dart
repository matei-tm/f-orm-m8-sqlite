import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'test_annotation_utils.dart';
import 'test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

LibraryReader _library;

void main() async {
  final path = testFilePath('test', 'src', 'model');
  _library =
      await initializeLibraryReaderForDirectory(path, "independent.dart");
  var e = getEmittedEntityForAnnotation("my_health_entries_table", _library);
  group('Independent entity tests', () {
    test('Test entity name', () async {
      expect(e.entityName, "my_health_entries_table");
    });
    test('Test model name', () async {
      expect(e.modelName, "HealthEntry");
    });

    test('Test attributes count', () async {
      expect(e.attributes.length, 2);
    });

    test('Has attribute id', () async {
      var hasId = e.attributes.containsKey("id");
      expect(hasId, true);
    });

    test('Has attribute description', () async {
      var hasDescription = e.attributes.containsKey("description");
      expect(hasDescription, true);
    });

    test('Ignored attribute futureData', () async {
      var hasFutureData = e.attributes.containsKey("futureData");
      expect(hasFutureData, false);
    });

    test('Entity is soft deletable', () async {
      var hasSoftDelete = e.hasSoftDelete;
      expect(hasSoftDelete, true);
    });

    test('Entity is with creation track', () async {
      var hasTrackCreate = e.hasTrackCreate;
      expect(hasTrackCreate, true);
    });

    test('Entity is with update track', () async {
      var hasTrackUpdate = e.hasTrackUpdate;
      expect(hasTrackUpdate, true);
    });
  });
}
