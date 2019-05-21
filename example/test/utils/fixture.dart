import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:test/test.dart';

class MockDatabase extends Mock implements Database {}

class MockDatabaseFactory extends Mock implements DatabaseFactory {}

class MockDatabaseAdapter extends Mock implements DatabaseAdapter {}

void initTestFixture(MockDatabaseAdapter mockDatabaseAdapter,
    MockDatabase database, dynamic sample01, dynamic sample02) {
  reset(database);
  reset(mockDatabaseAdapter);
  when(mockDatabaseAdapter.getDb(any))
      .thenAnswer((_) async => Future.value(database));

  when(database.close()).thenAnswer((_) async => Future<void>.value());

  when(database.execute(any)).thenAnswer((_) => Future<void>.value());

  when(database.insert(any, any)).thenAnswer((_) async => Future.value(1));

  var twoProxiesList = List<Map<String, dynamic>>();

  twoProxiesList.add(sample01.toMap());
  twoProxiesList.add(sample02.toMap());

  when(database.query(any, columns: anyNamed('columns'), where: "1"))
      .thenAnswer((_) async => Future.value(twoProxiesList));

  when(database.query(argThat(equals("to_do")),
          columns: anyNamed('columns'), where: "date_delete > 0"))
      .thenAnswer((_) async => Future.value(twoProxiesList));

  var oneProxyList = List<Map<String, dynamic>>();

  oneProxyList.add(sample01.toMap());

  when(database.query(any,
      columns: anyNamed('columns'),
      where: "1 AND id = ?",
      whereArgs: [1])).thenAnswer((_) async => Future.value(oneProxyList));

  when(database.query(any,
      columns: anyNamed('columns'),
      where: "date_delete > 0 AND id = ?",
      whereArgs: [1])).thenAnswer((_) async => Future.value(oneProxyList));

  when(database.query(any,
      columns: anyNamed('columns'),
      where: "account_id = ? AND 1",
      whereArgs: [2])).thenAnswer((_) async => Future.value(twoProxiesList));

  when(database.query(any,
          columns: anyNamed('columns'), where: "1 AND is_current = 1"))
      .thenAnswer((_) async => Future.value(oneProxyList));

  when(database.delete(any, where: 'id = ?', whereArgs: [1]))
      .thenAnswer((_) async => Future.value(1));

  when(database.delete(any)).thenAnswer((_) async => Future.value(1));

  when(database.update(any, any, where: 'id = ?', whereArgs: [1]))
      .thenAnswer((_) async => Future.value(1));

  when(database.rawQuery(any)).thenAnswer((_) async => Future.value([
        {"count": 9}
      ]));
}
