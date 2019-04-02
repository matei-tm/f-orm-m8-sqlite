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
  var e = getEmittedEntityForAnnotation("my_account_related_table", _library);
  group('Account related entity tests', () {
    test('Test entity name', () async {
      expect(e.entityName, "my_account_related_table");
    });
    test('Test model name', () async {
      expect(e.modelName, "HealthEntryAccountRelated");
    });

    test('Test attributes count', () async {
      expect(e.attributes.length, 3);
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

    test('Has attribute accountId', () async {
      var hasDescription = e.attributes.containsKey("accountId");
      expect(hasDescription, true);
    });
    
    test('Entity is not soft deletable', () async {
      var hasSoftDelete = e.hasSoftDelete;
      expect(hasSoftDelete, false);
    });

    test('Entity is not with creation track', () async {
      var hasTrackCreate = e.hasTrackCreate;
      expect(hasTrackCreate, false);
    });

    test('Entity is not with update track', () async {
      var hasTrackUpdate = e.hasTrackUpdate;
      expect(hasTrackUpdate, false);
    });
  });
}
