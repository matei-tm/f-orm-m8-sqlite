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
  Map<String, dynamic> proxySample01toMap = proxySample01.toMap();

  //fix soft delete guard
  proxySample01toMap['date_delete'] =
      toDoProxySample01.dateDelete.millisecondsSinceEpoch;
  Map<String, dynamic> proxySample02toMap = proxySample02.toMap();

  //fix soft delete guard
  proxySample02toMap['date_delete'] =
      toDoProxySample02.dateDelete.millisecondsSinceEpoch;

  setUp(() async {
    initTestFixture<Map<String, dynamic>>(
        databaseAdapter, database, proxySample01toMap, proxySample02toMap);
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
      var newEntityId = await databaseProvider.saveToDo(proxySample01);
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

    test('get Entities by Account id test', () async {
      var result = await databaseProvider.getToDoProxiesByAccountId(2);
      expect(result.length, 2);
    });

    test('softDelete test', () async {
      var result = await databaseProvider.softdeleteToDo(1);
      expect(result, 1);
    });
  });
}
