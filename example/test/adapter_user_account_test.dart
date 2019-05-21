import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';
import 'package:test/test.dart';

import 'utils/fixture.dart';
import 'utils/sample_repo.dart';

main() {
  Database database = MockDatabase();
  DatabaseAdapter databaseAdapter = MockDatabaseAdapter();
  DatabaseProvider databaseProvider = DatabaseProvider(databaseAdapter);

  UserAccountProxy proxySample01 = userAccountProxySample01;
  UserAccountProxy proxySample02 = userAccountProxySample02;

  setUp(() async {
    initTestFixture<Map<String, dynamic>>(databaseAdapter, database,
        proxySample01.toMap(), proxySample02.toMap());
  });

  tearDown(() async {
    reset(database);
    reset(databaseAdapter);
  });

  group('adapter UserAccount tests', () {
    test('create UserAccount test', () async {
      final createResult = () async {
        await databaseProvider.createUserAccountTable(database);
        return true;
      };

      expect(createResult(), completion(equals(true)));
    });

    test('save UserAccount test', () async {
      var newGymId = await databaseProvider.saveUserAccount(proxySample01);
      expect(newGymId, 1);
    });

    // test('get UserAccountProxies All test', () async {
    //   var gymList = await databaseProvider.getUserAccountProxiesAll();
    //   expect(gymList.length, 2);
    // });

    test('get UserAccountProxies Count test', () async {
      var result = await databaseProvider.getUserAccountProxiesCount();
      expect(result, 9);
    });

    // test('get UserAccount test', () async {
    //   var userAccount = await databaseProvider.getUserAccount(1);
    //   expect(userAccount.id, 1);
    // });

    test('delete UserAccount test', () async {
      var deletedId =
          await databaseProvider.deleteUserAccount(proxySample01.id);
      expect(deletedId, proxySample01.id);
    });

    test('delete UserAccount all test', () async {
      var result = await databaseProvider.deleteUserAccountProxiesAll();
      expect(result, true);
    });

    test('update UserAccount test', () async {
      var updatedId = await databaseProvider.updateUserAccount(proxySample01);
      expect(updatedId, proxySample01.id);
    });

    test('get current UserAccount test', () async {
      var userAccount = await databaseProvider.getCurrentUserAccount();
      expect(userAccount.id, 1);
    });
  });
}
