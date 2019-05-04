import 'package:mockito/mockito.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/models/gym_location.g.m8.dart';
import 'package:test/test.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

main() {
  group('mocking generics', () {
    test('initial mocking test', () async {
      final databaseHelper = MockDatabaseHelper();

      when(databaseHelper.getGymLocationProxiesAll())
          .thenAnswer((_) async => List<GymLocationProxy>());

      expect(await databaseHelper.getGymLocationProxiesAll(),
          TypeMatcher<List<GymLocationProxy>>());
    });
  });
}
