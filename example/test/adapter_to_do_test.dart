import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/models/to_do.g.m8.dart';
import 'package:test/test.dart';

import 'utils/fixture.dart';
import 'utils/sample_repo.dart';

main() {
  Database database = MockDatabase();
  DatabaseAdapter databaseAdapter = MockDatabaseAdapter();
  DatabaseProvider databaseProvider = DatabaseProvider(databaseAdapter);

  ToDoProxy proxySample01 = toDoProxySample01;
  ToDoProxy proxySample02 = toDoProxySample02;

  setUp(() async {
    initTestFixture(databaseAdapter, database, proxySample01, proxySample02);
  });

  tearDown(() async {
    reset(database);
    reset(databaseAdapter);
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
      var newGymId = await databaseProvider.saveToDo(proxySample01);
      expect(newGymId, 1);
    });

    // test('get ToDoProxies All test', () async {
    //   var gymList = await databaseProvider.getToDoProxiesAll();
    //   expect(gymList.length, 2);
    // });

    test('get ToDoProxies Count test', () async {
      var result = await databaseProvider.getToDoProxiesCount();
      expect(result, 9);
    });

    // test('get ToDo test', () async {
    //   var toDo = await databaseProvider.getToDo(1);
    //   expect(toDo.id, 1);
    // });

    test('delete ToDo test', () async {
      var deletedId = await databaseProvider.deleteToDo(proxySample01.id);
      expect(deletedId, proxySample01.id);
    });

    test('delete ToDo all test', () async {
      var result = await databaseProvider.deleteToDoProxiesAll();
      expect(result, true);
    });

    test('update ToDo test', () async {
      var updatedId = await databaseProvider.updateToDo(proxySample01);
      expect(updatedId, proxySample01.id);
    });
  });
}
