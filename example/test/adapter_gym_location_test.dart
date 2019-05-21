import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/models/gym_location.g.m8.dart';
import 'package:test/test.dart';

import 'utils/fixture.dart';
import 'utils/sample_repo.dart';

main() {
  Database database = MockDatabase();
  DatabaseAdapter databaseAdapter = MockDatabaseAdapter();
  DatabaseProvider databaseProvider = DatabaseProvider(databaseAdapter);

  GymLocationProxy proxySample01 = gymLocationProxySample01;
  GymLocationProxy proxySample02 = gymLocationProxySample02;

  setUp(() async {
    initTestFixture(databaseAdapter, database, proxySample01, proxySample02);
  });

  tearDown(() async {
    reset(database);
    reset(databaseAdapter);
  });

  group('adapter GymLocation tests', () {
    test('create GymLocation test', () async {
      final createResult = () async {
        await databaseProvider.createGymLocationTable(database);
        return true;
      };

      expect(createResult(), completion(equals(true)));
    });

    test('save GymLocation test', () async {
      var newGymId = await databaseProvider.saveGymLocation(proxySample01);
      expect(newGymId, 1);
    });

    test('get GymLocationProxies All test', () async {
      var gymList = await databaseProvider.getGymLocationProxiesAll();
      expect(gymList.length, 2);
    });

    test('get GymLocationProxies Count test', () async {
      var result = await databaseProvider.getGymLocationProxiesCount();
      expect(result, 9);
    });

    test('get GymLocation test', () async {
      var gymLocation = await databaseProvider.getGymLocation(1);
      expect(gymLocation.id, 1);
    });

    test('delete GymLocation test', () async {
      var deletedId =
          await databaseProvider.deleteGymLocation(proxySample01.id);
      expect(deletedId, proxySample01.id);
    });

    test('delete GymLocation all test', () async {
      var result = await databaseProvider.deleteGymLocationProxiesAll();
      expect(result, true);
    });

    test('update GymLocation test', () async {
      var updatedId = await databaseProvider.updateGymLocation(proxySample01);
      expect(updatedId, proxySample01.id);
    });
  });
}
