import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';

class MockDatabase extends Mock implements Database {}

class MockDatabaseFactory extends Mock implements DatabaseFactory {}

class MockDatabaseAdapter extends Mock implements DatabaseAdapter {}

void initTestFixture(MockDatabaseAdapter mockDatabaseAdapter,
    MockDatabase database, dynamic sample01, dynamic sample02) {
  reset(database);
  reset(mockDatabaseAdapter);
  when(mockDatabaseAdapter.getDb(any)).thenAnswer((_) async => database);

  when(database.close()).thenAnswer((_) async {
    return;
  });

  when(database.execute(any)).thenAnswer((_) async {
    return;
  });

  when(database.insert(any, any)).thenAnswer((_) async => 1);

  dynamic twoProxiesList = List<Map<String, dynamic>>();

  twoProxiesList.add(sample01.toMap());
  twoProxiesList.add(sample02.toMap());

  when(database.query(any, columns: anyNamed('columns'), where: "1"))
      .thenAnswer((_) async => twoProxiesList);

  dynamic oneProxyList = List<Map<String, dynamic>>();

  oneProxyList.add(sample01.toMap());

  when(database.query(any,
      columns: anyNamed('columns'),
      where: "1 AND id = ?",
      whereArgs: [1])).thenAnswer((_) async => oneProxyList);

  when(database.delete(any, where: 'id = ?', whereArgs: [1]))
      .thenAnswer((_) async => 1);

  when(database.delete(any)).thenAnswer((_) async => 1);

  when(database.update(any, any, where: 'id = ?', whereArgs: [1]))
      .thenAnswer((_) async => 1);

  when(database.rawQuery(any)).thenAnswer((_) async => [
        {"count": 9}
      ]);
}
