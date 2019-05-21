import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/models/health_entry.g.m8.dart';
import 'package:test/test.dart';

import 'utils/fixture.dart';
import 'utils/sample_repo.dart';

main() {
  Database database = MockDatabase();
  DatabaseAdapter databaseAdapter = MockDatabaseAdapter();
  DatabaseProvider databaseProvider = DatabaseProvider(databaseAdapter);

  HealthEntryProxy proxySample01 = healthEntryProxySample01;
  HealthEntryProxy proxySample02 = healthEntryProxySample02;

  setUp(() async {
    initTestFixture<Map<String, dynamic>>(databaseAdapter, database,
        proxySample01.toMap(), proxySample02.toMap());
  });

  tearDown(() async {
    reset(database);
    reset(databaseAdapter);
  });
  group('adapter HealthEntry tests', () {
    test('create Entity test', () async {
      final createResult = () async {
        await databaseProvider.createHealthEntryTable(database);
        return true;
      };

      expect(createResult(), completion(equals(true)));
    });

    test('save Entity test', () async {
      var newId = await databaseProvider.saveHealthEntry(proxySample01);
      expect(newId, 1);
    });

    // test('get Entity All test', () async {
    //   var fullList = await databaseProvider.getHealthEntryProxiesAll();
    //   expect(fullList.length, 2);
    // });

    test('get Entity Count test', () async {
      var result = await databaseProvider.getHealthEntryProxiesCount();
      expect(result, 9);
    });

    // test('get Entity test', () async {
    //   var result = await databaseProvider.getHealthEntry(1);
    //   expect(result.id, 1);
    // });

    test('delete Entity test', () async {
      var deletedId =
          await databaseProvider.deleteHealthEntry(proxySample01.id);
      expect(deletedId, proxySample01.id);
    });

    test('delete Entity all test', () async {
      var result = await databaseProvider.deleteHealthEntryProxiesAll();
      expect(result, true);
    });

    test('update Entity test', () async {
      var updatedId = await databaseProvider.updateHealthEntry(proxySample01);
      expect(updatedId, proxySample01.id);
    });

    // test('get Entities by Account id test', () async {
    //   var result = await databaseProvider.getHealthEntryProxiesByAccountId(2);
    //   expect(result.length, 2);
    // });
  });
}
