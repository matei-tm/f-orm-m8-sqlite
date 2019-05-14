import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:test/test.dart';
import 'utils/sample_repo.dart';

class MockDatabase extends Mock implements Database {}

class MockDatabaseFactory extends Mock implements DatabaseFactory {}

class MockDatabaseBuilder extends Mock implements DatabaseBuilder {}

void initTestFixture(MockDatabaseBuilder mockDatabaseBuilder) {
  final database = MockDatabase();

  when(mockDatabaseBuilder.getDb(any)).thenAnswer((_) async => database);

  when(database.close()).thenAnswer((_) async {
    return;
  });

  when(database.execute(any)).thenAnswer((_) async {
    return;
  });

  when(database.insert(any, any)).thenAnswer((_) async => 1);
}

main() {
  group('adapter GymLocation tests', () {
    final database = MockDatabase();
    final databaseBuilder = MockDatabaseBuilder();

    test('createGymLocation test', () async {
      initTestFixture(databaseBuilder);

      var databaseAdapter = DatabaseHelper(databaseBuilder);
      await databaseAdapter.createGymLocationTable(database);

      var newGymId =
          await databaseAdapter.saveGymLocation(gymLocationProxySample01);
      expect(newGymId, 1);
    });
  });
}
