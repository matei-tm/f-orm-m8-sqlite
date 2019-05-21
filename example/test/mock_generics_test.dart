import 'package:mockito/mockito.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/models/gym_location.g.m8.dart';
import 'package:test/test.dart';

class MockDatabaseProvider extends Mock implements DatabaseProvider {}

main() {
  group('mocking generics', () {
    test('initial mocking test', () async {
      final databaseProvider = MockDatabaseProvider();

      when(databaseProvider.getGymLocationProxiesAll())
          .thenAnswer((_) async => Future.value(List<GymLocationProxy>()));

      expect(await databaseProvider.getGymLocationProxiesAll(),
          TypeMatcher<List<GymLocationProxy>>());
    });
  });
}
