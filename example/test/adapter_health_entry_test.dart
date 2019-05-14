import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/models/health_entry.g.m8.dart';
import 'package:test/test.dart';

import 'utils/fixture.dart';
import 'utils/sample_repo.dart';

main() {
  Database database = MockDatabase();
  DatabaseBuilder databaseBuilder = MockDatabaseBuilder();
  DatabaseHelper databaseAdapter = DatabaseHelper(databaseBuilder);

  HealthEntryProxy proxySample01 = healthEntryProxySample01;
  HealthEntryProxy proxySample02 = healthEntryProxySample02;

  setUp(() async {
    initTestFixture(databaseBuilder, database, proxySample01, proxySample02);
  });

  tearDown(() async {
    reset(database);
    reset(databaseBuilder);
    clearInteractions(database);
    clearInteractions(databaseBuilder);
  });
  group('adapter HealthEntry tests', () {
    test('create Entity test', () async {
      final createResult = () async {
        await databaseAdapter.createHealthEntryTable(database);
        return true;
      };

      expect(createResult(), completion(equals(true)));
    });

    test('save Entity test', () async {
      var newId = await databaseAdapter.saveHealthEntry(proxySample01);
      expect(newId, 1);
    });

    test('get Entity All test', () async {
      var fullList = await databaseAdapter.getHealthEntryProxiesAll();
      expect(fullList.length, 2);
    });

    test('get Entity Count test', () async {
      var result = await databaseAdapter.getHealthEntryProxiesCount();
      expect(result, 9);
    });

    test('get Entity test', () async {
      var result = await databaseAdapter.getHealthEntry(1);
      expect(result.id, 1);
    });

    test('delete Entity test', () async {
      var deletedId = await databaseAdapter.deleteHealthEntry(proxySample01.id);
      expect(deletedId, proxySample01.id);
    });

    test('delete Entity all test', () async {
      var result = await databaseAdapter.deleteHealthEntryProxiesAll();
      expect(result, true);
    });

    test('update Entity test', () async {
      var updatedId = await databaseAdapter.updateHealthEntry(proxySample01);
      expect(updatedId, proxySample01.id);
    });
  });
}
