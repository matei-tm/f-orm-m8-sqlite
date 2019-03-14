import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'test_annotation_utils.dart';
import 'test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

LibraryReader _library;

void main() async {
  final path = testFilePath('test', 'src', 'model');
  _library = await initializeLibraryReaderForDirectory(path, "account.dart");
  var e = getEmittedEntityForAnnotation("my_account_table", _library);
  group('Account related entity tests', () {
    test('Test entity name', () async {
      expect(e.entityName, "my_account_table");
    });
    test('Test model name', () async {
      expect(e.modelName, "UserAccount");
    });

    test('Test attributes count', () async {
      expect(e.attributes.length, 5);
    });

    test('Has attribute _id', () async {
      var hasId = e.attributes.containsKey("_id");
      expect(hasId, true);
    });

    test('Has attribute _description', () async {
      var hasDescription = e.attributes.containsKey("_description");
      expect(hasDescription, true);
    });

    test('Ignored attribute _futureData', () async {
      var hasFutureData = e.attributes.containsKey("_futureData");
      expect(hasFutureData, false);
    });

    test('Has attribute _abbreviation', () async {
      var hasDescription = e.attributes.containsKey("_abbreviation");
      expect(hasDescription, true);
    });

    test('Has attribute _email', () async {
      var hasDescription = e.attributes.containsKey("_email");
      expect(hasDescription, true);
    });
    test('Has attribute _userName', () async {
      var hasDescription = e.attributes.containsKey("_userName");
      expect(hasDescription, true);
    });
  });
}
