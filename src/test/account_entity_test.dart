import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'test_annotation_utils.dart';
import 'test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() {
  LibraryReader library;
  final path = testFilePath('test', 'src', 'model');
  var e;

  setUp(() async {
    library = await initializeLibraryReaderForDirectory(path, "account.dart");
    e = getEmittedEntityForAnnotation("my_account_table", library);
  });

  group('Account entity tests', () {
    test('Test entity name', () {
      expect(e.entityName, "my_account_table");
    });
    test('Test model name', () {
      expect(e.modelName, "UserAccount");
    });

    test('Test attributes count', () {
      expect(e.attributes.length, 6);
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

    test('Has attribute abbreviation', () {
      var hasAttribute = e.attributes.containsKey("abbreviation");
      expect(hasAttribute, true);
    });

    test('Has attribute email', () {
      var hasAttribute = e.attributes.containsKey("email");
      expect(hasAttribute, true);
    });

    test('Has attribute userName', () {
      var hasAttribute = e.attributes.containsKey("userName");
      expect(hasAttribute, true);
    });

    test('Has attribute isCurrent', () {
      var hasAttribute = e.attributes.containsKey("isCurrent");
      expect(hasAttribute, true);
    });

    test('Entity is not soft deletable', () {
      var hasSoftDelete = e.hasSoftDelete;
      expect(hasSoftDelete, false);
    });

    test('Entity is not with creation track', () {
      var hasTrackCreate = e.hasTrackCreate;
      expect(hasTrackCreate, false);
    });

    test('Entity is not with update track', () {
      var hasTrackUpdate = e.hasTrackUpdate;
      expect(hasTrackUpdate, false);
    });
  });
}
