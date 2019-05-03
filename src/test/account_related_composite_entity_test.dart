import 'dart:io';

import 'package:f_orm_m8_sqlite/generator/core.dart';
import 'package:f_orm_m8_sqlite/generator/writers/entity_writer_factory.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'utils/test_annotation_utils.dart';
import 'utils/test_file_utils.dart';
import 'package:source_gen_test/source_gen_test.dart';

void main() {
  LibraryReader library;
  final path = testFilePath('test', 'src', 'model');
  final caliber0Path =
      testFilePath('test', 'out', 'account_related_composite.0.caliber');

  EmittedEntity e;
  var entityWriter;

  setUp(() async {
    library = await initializeLibraryReaderForDirectory(
        path, "account_related_composite.dart");
    e = getEmittedEntityForAnnotation("my_account_related_table", library);
    entityWriter = EntityWriterFactory().getWriter(e);
  });

  group('Account related composite entity tests', () {
    test('Test entity name', () {
      expect(e.entityName, "my_account_related_table");
    });
    test('Test model name', () {
      expect(e.modelName, "HealthEntryAccountRelated");
    });

    test('Test attributes count', () {
      expect(e.attributes.length, 3);
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

    test('Has attribute accountId', () {
      var hasAttribute = e.attributes.containsKey("accountId");
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

    test('Test raw output', () async {
      final output = entityWriter.toString();
      final expected = await File(caliber0Path).readAsString();
      expect(output, expected);
    });
  });
}
