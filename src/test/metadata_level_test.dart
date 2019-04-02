import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'test_annotation_utils.dart';
import 'test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

LibraryReader _library;

void main() async {
  final path = testFilePath('test', 'src', 'model');
  _library = await initializeLibraryReaderForDirectory(
      path, "metadata_level_probe.dart");
  var e = getEmittedEntityForAnnotation("my_health_entries_table", _library);
  group('Attributes metadata level tests', () {
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

    test('Has id metadata level 22', () async {
      var metadataLevel = e.attributes["id"].metadataLevel;
      expect(metadataLevel, 22);
    });

    test('Has attribute description', () async {
      var hasDescription = e.attributes.containsKey("description");
      expect(hasDescription, true);
    });

    test('Has description metadata level 4', () async {
      var metadataLevel = e.attributes["id"].metadataLevel;
      expect(metadataLevel, 4);
    });

    test('Ignored attribute futureData', () async {
      var hasFutureData = e.attributes.containsKey("futureData");
      expect(hasFutureData, false);
    });
  });
}
