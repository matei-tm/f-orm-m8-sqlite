import 'package:f_orm_m8_sqlite/generator/core.dart';
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
    library = await initializeLibraryReaderForDirectory(
        path, "type_checkers_probe.dart");
    e = getEmittedEntityForAnnotation("receipt", library);
  });

  group('Type checkers tests', () {
    test('Test entity name', () {
      expect(e.entityName, "receipt");
    });
    test('Test model name', () {
      expect(e.modelName, "Receipt");
    });

    test('Test attributes count', () {
      expect(e.attributes.length, 9);
    });

    test('Has attribute id', () {
      var hasId = e.attributes.containsKey("id");
      expect(hasId, true);
    });

    test('Has attribute isBio', () {
      var hasDescription = e.attributes.containsKey("isBio");
      expect(hasDescription, true);
    });
    test('Has attribute expirationDate', () {
      var hasDescription = e.attributes.containsKey("expirationDate");
      expect(hasDescription, true);
    });
    test('Has attribute quantity', () {
      var hasDescription = e.attributes.containsKey("quantity");
      expect(hasDescription, true);
    });
    test('Has attribute decomposingDuration', () {
      var hasDescription = e.attributes.containsKey("decomposingDuration");
      expect(hasDescription, true);
    });
    test('Has attribute numberOfItems', () {
      var hasDescription = e.attributes.containsKey("numberOfItems");
      expect(hasDescription, true);
    });

    test('Has attribute storageTemperature', () {
      var hasDescription = e.attributes.containsKey("storageTemperature");
      expect(hasDescription, true);
    });

    test('Has attribute description', () {
      var hasDescription = e.attributes.containsKey("description");
      expect(hasDescription, true);
    });

    test('Has Ignored attribute futureData', () {
      var hasFutureData = e.attributes.containsKey("futureData");
      expect(hasFutureData, false);
    });
  });
}
