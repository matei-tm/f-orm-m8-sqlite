import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/models/receipt.g.m8.dart';
import 'package:test/test.dart';

import 'utils/fixture.dart';
import 'utils/sample_repo.dart';

main() {
  Database database = MockDatabase();
  DatabaseAdapter databaseAdapter = MockDatabaseAdapter();
  DatabaseProvider databaseProvider = DatabaseProvider(databaseAdapter);

  ReceiptProxy proxySample01 = receiptProxySample01;
  ReceiptProxy proxySample02 = receiptProxySample02;

  setUp(() async {
    initTestFixture(databaseAdapter, database, proxySample01, proxySample02);
  });

  tearDown(() async {
    reset(database);
    reset(databaseAdapter);
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
      var newId = await databaseProvider.saveReceipt(proxySample01);
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
      var deletedId = await databaseProvider.deleteReceipt(proxySample01.id);
      expect(deletedId, proxySample01.id);
    });

    test('delete Entity all test', () async {
      var result = await databaseProvider.deleteReceiptProxiesAll();
      expect(result, true);
    });

    test('update Entity test', () async {
      var updatedId = await databaseProvider.updateReceipt(proxySample01);
      expect(updatedId, proxySample01.id);
    });
  });
}
