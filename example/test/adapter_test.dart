import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:test/test.dart';

import 'utils/fixture.dart';
import 'utils/sample_repo.dart';

main() {
  Database database = MockDatabase();
  DatabaseAdapter databaseAdapter = MockDatabaseAdapter();
  DatabaseProvider databaseProvider;

  setUp(() async {
    initTestFixture(databaseAdapter, database);
    databaseProvider = DatabaseProvider(databaseAdapter);
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
      var newGymId =
          await databaseProvider.saveGymLocation(gymLocationProxySample01);
      expect(newGymId, 1);
    });

    // test('get GymLocationProxies All test', () async {
    //   var gymList = await databaseProvider.getGymLocationProxiesAll();
    //   expect(gymList.length, 2);
    // });

    test('get GymLocationProxies Count test', () async {
      var result = await databaseProvider.getGymLocationProxiesCount();
      expect(result, 9);
    });

    // test('get GymLocation test', () async {
    //   var gymLocation = await databaseProvider.getGymLocation(1);
    //   expect(gymLocation.id, 1);
    // });

    test('delete GymLocation test', () async {
      var deletedId =
          await databaseProvider.deleteGymLocation(gymLocationProxySample01.id);
      expect(deletedId, gymLocationProxySample01.id);
    });

    test('delete GymLocation all test', () async {
      var result = await databaseProvider.deleteGymLocationProxiesAll();
      expect(result, true);
    });

    test('update GymLocation test', () async {
      var updatedId =
          await databaseProvider.updateGymLocation(gymLocationProxySample01);
      expect(updatedId, gymLocationProxySample01.id);
    });
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
      var newId =
          await databaseProvider.saveHealthEntry(healthEntryProxySample01);
      expect(newId, 1);
    });

    test('get Entity All test', () async {
      var fullList = await databaseProvider.getHealthEntryProxiesAll();
      expect(fullList.length, 2);
    });

    test('get Entity Count test', () async {
      var result = await databaseProvider.getHealthEntryProxiesCount();
      expect(result, 9);
    });

    test('get Entity test', () async {
      var result = await databaseProvider.getHealthEntry(1);
      expect(result.id, 1);
    });

    test('delete Entity test', () async {
      var deletedId =
          await databaseProvider.deleteHealthEntry(healthEntryProxySample01.id);
      expect(deletedId, healthEntryProxySample01.id);
    });

    test('delete Entity all test', () async {
      var result = await databaseProvider.deleteHealthEntryProxiesAll();
      expect(result, true);
    });

    test('update Entity test', () async {
      var updatedId =
          await databaseProvider.updateHealthEntry(healthEntryProxySample01);
      expect(updatedId, healthEntryProxySample01.id);
    });

    test('get Entities by Account id test', () async {
      var result = await databaseProvider.getHealthEntryProxiesByAccountId(2);
      expect(result.length, 2);
    });
  });

  group('adapter Receipt tests', () {
    test('create Entity test', () async {
      final createResult = () async {
        await databaseProvider.createReceiptTable(database);
        return true;
      };

      expect(createResult(), completion(equals(true)));
    });

    test('save Entity test', () async {
      var newId = await databaseProvider.saveReceipt(receiptProxySample01);
      expect(newId, 1);
    });

    test('get Entity All test', () async {
      var fullList = await databaseProvider.getReceiptProxiesAll();
      expect(fullList.length, 2);
    });

    test('get Entity Count test', () async {
      var result = await databaseProvider.getReceiptProxiesCount();
      expect(result, 9);
    });

    test('get Entity test', () async {
      var result = await databaseProvider.getReceipt(1);
      expect(result.id, 1);
    });

    test('delete Entity test', () async {
      var deletedId =
          await databaseProvider.deleteReceipt(receiptProxySample01.id);
      expect(deletedId, receiptProxySample01.id);
    });

    test('delete Entity all test', () async {
      var result = await databaseProvider.deleteReceiptProxiesAll();
      expect(result, true);
    });

    test('update Entity test', () async {
      var updatedId =
          await databaseProvider.updateReceipt(receiptProxySample01);
      expect(updatedId, receiptProxySample01.id);
    });
  });

  group('adapter ToDo tests', () {
    test('create ToDo test', () async {
      final createResult = () async {
        await databaseProvider.createToDoTable(database);
        return true;
      };

      expect(createResult(), completion(equals(true)));
    });

    test('save ToDo test', () async {
      var newEntityId = await databaseProvider.saveToDo(toDoProxySample01);
      expect(newEntityId, 1);
    });

    test('get ToDoProxies All test', () async {
      var entityList = await databaseProvider.getToDoProxiesAll();
      expect(entityList.length, 2);
    });

    test('get ToDoProxies Count test', () async {
      var result = await databaseProvider.getToDoProxiesCount();
      expect(result, 9);
    });

    test('get ToDo test', () async {
      var toDo = await databaseProvider.getToDo(1);
      expect(toDo.id, 1);
    });

    test('delete ToDo test', () async {
      var deletedId = await databaseProvider.deleteToDo(toDoProxySample01.id);
      expect(deletedId, toDoProxySample01.id);
    });

    test('delete ToDo all test', () async {
      var result = await databaseProvider.deleteToDoProxiesAll();
      expect(result, true);
    });

    test('update ToDo test', () async {
      var updatedId = await databaseProvider.updateToDo(toDoProxySample01);
      expect(updatedId, toDoProxySample01.id);
    });

    test('get Entities by Account id test', () async {
      var result = await databaseProvider.getToDoProxiesByAccountId(2);
      expect(result.length, 2);
    });

    test('softDelete test', () async {
      var result = await databaseProvider.softdeleteToDo(1);
      expect(result, 1);
    });
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
      var newGymId =
          await databaseProvider.saveUserAccount(userAccountProxySample01);
      expect(newGymId, 1);
    });

    test('get UserAccountProxies All test', () async {
      var gymList = await databaseProvider.getUserAccountProxiesAll();
      expect(gymList.length, 2);
    });

    test('get UserAccountProxies Count test', () async {
      var result = await databaseProvider.getUserAccountProxiesCount();
      expect(result, 9);
    });

    test('get UserAccount test', () async {
      var userAccount = await databaseProvider.getUserAccount(1);
      expect(userAccount.id, 1);
    });

    test('delete UserAccount test', () async {
      var deletedId =
          await databaseProvider.deleteUserAccount(userAccountProxySample01.id);
      expect(deletedId, userAccountProxySample01.id);
    });

    test('delete UserAccount all test', () async {
      var result = await databaseProvider.deleteUserAccountProxiesAll();
      expect(result, true);
    });

    test('update UserAccount test', () async {
      var updatedId =
          await databaseProvider.updateUserAccount(userAccountProxySample01);
      expect(updatedId, userAccountProxySample01.id);
    });

    test('get current UserAccount test', () async {
      var userAccount = await databaseProvider.getCurrentUserAccount();
      expect(userAccount.id, 1);
    });

    test('set current UserAccount test', () async {
      var result = await databaseProvider.setCurrentUserAccount(2);
      expect(result, 2);
    });
  });
}
