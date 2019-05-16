import 'package:sqlite_m8_demo/models/receipt.g.m8.dart';
import 'package:test/test.dart';

import 'utils/sample_repo.dart';

main() {
  group('ReceiptProxy test', () {
    test('fromMap', () async {
      var receiptFromMap = ReceiptProxy.fromMap(receiptMapSample01);

      expect(receiptFromMap, TypeMatcher<ReceiptProxy>());
      expect(receiptFromMap.id, receiptProxySample01.id);
      expect(receiptFromMap.description, receiptProxySample01.description);
      expect(receiptFromMap.dateCreate, receiptProxySample01.dateCreate);
      expect(receiptFromMap.dateUpdate, receiptProxySample01.dateUpdate);
      expect(receiptFromMap.isBio, receiptProxySample01.isBio);
      expect(
          receiptFromMap.expirationDate, receiptProxySample01.expirationDate);
      expect(receiptFromMap.quantity, receiptProxySample01.quantity);
      expect(receiptFromMap.numberOfItems, receiptProxySample01.numberOfItems);
      expect(receiptFromMap.storageTemperature,
          receiptProxySample01.storageTemperature);
      expect(receiptFromMap.decomposingDuration,
          receiptProxySample01.decomposingDuration);
      expect(receiptFromMap.numberOfMolecules,
          receiptProxySample01.numberOfMolecules);
    });

    test('toMap', () async {
      var receiptMapFromInstance = receiptProxySample01.toMap();

      expect(receiptMapFromInstance, receiptMapSample01);
    });

    test('backAndForthMap', () async {
      var receiptFromMap = ReceiptProxy.fromMap(receiptMapSample01);
      var receiptToMap = receiptFromMap.toMap();

      expect(receiptToMap, receiptMapSample01);
    });
  });
}
