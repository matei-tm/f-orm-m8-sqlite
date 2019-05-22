import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';

import 'sample_repo.dart';

class MockDatabase extends Mock implements Database {}

class MockDatabaseFactory extends Mock implements DatabaseFactory {}

class MockDatabaseAdapter extends Mock implements DatabaseAdapter {}

void initTestFixture(
    MockDatabaseAdapter mockDatabaseAdapter, MockDatabase database) {
  reset(database);
  reset(mockDatabaseAdapter);

  when(mockDatabaseAdapter.getDb(captureAny))
      .thenAnswer((_) => Future.value(database));

  when(database.close()).thenAnswer((_) async => Future<void>.value());

  when(database.execute(any)).thenAnswer((_) => Future<void>.value());

  when(database.insert(any, any)).thenAnswer((_) async => Future.value(1));

  when(database.query('gym_location', columns: anyNamed('columns'), where: "1"))
      .thenAnswer((_) async => Future.value([
            gymLocationProxySample01.toMap(),
            gymLocationProxySample02.toMap()
          ]));

  when(database.query('gym_location',
          columns: anyNamed('columns'), where: "1 AND id = ?", whereArgs: [1]))
      .thenAnswer(
          (_) async => Future.value([gymLocationProxySample01.toMap()]));

  when(database.query('health_entry', columns: anyNamed('columns'), where: "1"))
      .thenAnswer((_) async => Future.value([
            healthEntryProxySample01.toMap(),
            healthEntryProxySample02.toMap()
          ]));

  when(database.query('health_entry',
          columns: anyNamed('columns'), where: "1 AND id = ?", whereArgs: [1]))
      .thenAnswer(
          (_) async => Future.value([healthEntryProxySample01.toMap()]));

  when(database
      .query('health_entry',
          columns: anyNamed('columns'),
          where: "account_id = ? AND 1",
          whereArgs: [2])).thenAnswer((_) async => Future.value(
      [healthEntryProxySample01.toMap(), healthEntryProxySample02.toMap()]));

  when(database.query('receipt', columns: anyNamed('columns'), where: "1"))
      .thenAnswer((_) async => Future.value(
          [receiptProxySample01.toMap(), receiptProxySample02.toMap()]));

  when(database.query('receipt',
          columns: anyNamed('columns'), where: "1 AND id = ?", whereArgs: [1]))
      .thenAnswer((_) async => Future.value([receiptProxySample01.toMap()]));

  var toDoMap01 = toDoProxySample01.toMap();
  toDoMap01["date_delete"] =
      toDoProxySample01.dateDelete.millisecondsSinceEpoch;
  var toDoMap02 = toDoProxySample02.toMap();
  toDoMap02["date_delete"] =
      toDoProxySample02.dateDelete.millisecondsSinceEpoch;

  when(database.query('to_do',
          columns: anyNamed('columns'), where: "date_delete > 0"))
      .thenAnswer((_) async => Future.value([toDoMap01, toDoMap02]));

  when(database.query('to_do',
      columns: anyNamed('columns'),
      where: "date_delete > 0 AND id = ?",
      whereArgs: [1])).thenAnswer((_) async => Future.value([toDoMap01]));

  when(database.query('to_do',
          columns: anyNamed('columns'),
          where: "user_account_id = ? AND date_delete > 0",
          whereArgs: [2]))
      .thenAnswer((_) async => Future.value([toDoMap01, toDoMap02]));

  when(database.query('user_account', columns: anyNamed('columns'), where: "1"))
      .thenAnswer((_) async => Future.value([
            userAccountProxySample01.toMap(),
            userAccountProxySample02.toMap()
          ]));

  when(database.query('user_account',
          columns: anyNamed('columns'), where: "1 AND id = ?", whereArgs: [1]))
      .thenAnswer(
          (_) async => Future.value([userAccountProxySample01.toMap()]));

  when(database.query('user_account',
          columns: anyNamed('columns'), where: "1 AND is_current = 1"))
      .thenAnswer(
          (_) async => Future.value([userAccountProxySample01.toMap()]));

  when(database.delete(any, where: 'id = ?', whereArgs: [1]))
      .thenAnswer((_) async => Future.value(1));

  when(database.delete(any)).thenAnswer((_) async => Future.value(1));

  when(database.update(any, any, where: 'id = ?', whereArgs: [1]))
      .thenAnswer((_) async => Future.value(1));

  when(database.update(any, any, where: '1 AND id = ?', whereArgs: [2]))
      .thenAnswer((_) async => Future.value(2));

  when(database.rawQuery(any)).thenAnswer((_) async => Future.value([
        {"count": 9}
      ]));
}
