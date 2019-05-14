import 'package:mockito/mockito.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/models/receipt.g.m8.dart';
import 'package:test/test.dart';

import 'utils/fixture.dart';
import 'utils/sample_repo.dart';

main() {
  Database database = MockDatabase();
  DatabaseBuilder databaseBuilder = MockDatabaseBuilder();
  DatabaseProvider databaseAdapter = DatabaseProvider(databaseBuilder);

  ReceiptProxy proxySample01 = receiptProxySample01;
  ReceiptProxy proxySample02 = receiptProxySample02;

  setUp(() async {
    initTestFixture(databaseBuilder, database, proxySample01, proxySample02);
  });

  tearDown(() async {
    reset(database);
    reset(databaseBuilder);
  });
  group('adapter Receipt tests', () {
    test('create Entity test', () async {
      final createResult = () async {
        await databaseAdapter.createReceiptTable(database);
        return true;
      };

      expect(createResult(), completion(equals(true)));
    });

    test('save Entity test', () async {
      var newId = await databaseAdapter.saveReceipt(proxySample01);
      expect(newId, 1);
    });

// // todo
    // test('get Entity All test', () async {
    //   var fullList = await databaseAdapter.getReceiptProxiesAll();
    //   expect(fullList.length, 2);
    // });

    test('get Entity Count test', () async {
      var result = await databaseAdapter.getReceiptProxiesCount();
      expect(result, 9);
    });

// // todo
    // test('get Entity test', () async {
    //   var result = await databaseAdapter.getReceipt(1);
    //   expect(result.id, 1);
    // });

    test('delete Entity test', () async {
      var deletedId = await databaseAdapter.deleteReceipt(proxySample01.id);
      expect(deletedId, proxySample01.id);
    });

    test('delete Entity all test', () async {
      var result = await databaseAdapter.deleteReceiptProxiesAll();
      expect(result, true);
    });

    test('update Entity test', () async {
      var updatedId = await databaseAdapter.updateReceipt(proxySample01);
      expect(updatedId, proxySample01.id);
    });
  });
}
