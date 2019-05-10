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
      expect(e.attributes.length, 7);
    });

    test('Has attribute id', () {
      var hasId = e.attributes.containsKey("id");
      expect(hasId, true);
    });

    test('Has attribute isBio', () {
      var hasField = e.attributes.containsKey("isBio");
      expect(hasField, true);
    });
    test('Has attribute expirationDate', () {
      var hasField = e.attributes.containsKey("expirationDate");
      expect(hasField, true);
    });
    test('Has attribute quantity', () {
      var hasField = e.attributes.containsKey("quantity");
      expect(hasField, true);
    });
    test('Has attribute numberOfItems', () {
      var hasField = e.attributes.containsKey("numberOfItems");
      expect(hasField, true);
    });

    test('Has attribute storageTemperature', () {
      var hasField = e.attributes.containsKey("storageTemperature");
      expect(hasField, true);
    });

    test('Has attribute description', () {
      var hasField = e.attributes.containsKey("description");
      expect(hasField, true);
    });

    test('Hasn\'t Ignored attribute futureData', () {
      var hasField = e.attributes.containsKey("futureData");
      expect(hasField, false);
    });

    test('Hasn\'t NotImplemented attribute mapMemo', () {
      var hasField = e.attributes.containsKey("mapMemo");
      expect(hasField, false);
    });

    test('Hasn\'t NotImplemented attribute listMemo', () {
      var hasField = e.attributes.containsKey("listMemo");
      expect(hasField, false);
    });

    test('Hasn\'t attribute decomposingDuration', () {
      var hasField = e.attributes.containsKey("decomposingDuration");
      expect(hasField, false);
    });

    test('Hasn\'t NotImplemented attribute numberOfMolecules', () {
      var hasField = e.attributes.containsKey("numberOfMolecules");
      expect(hasField, false);
    });
  });
}
