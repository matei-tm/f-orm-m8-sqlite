import 'package:sqlite_m8_demo/models/receipt.g.m8.dart';
import 'package:test/test.dart';

main() {
  var testMap = {
    "id": 1,
    "is_bio": 1,
    "expiration_date": 1557701763036,
    "quantity": 3.1415,
    "number_of_items": 44,
    "storage_temperature": 106,
    "description": "Happiness forever",
    "date_create": 1557701763037,
    "date_update": 1557701763038,
  };

  var receiptProxy = ReceiptProxy()
    ..id = 1
    ..isBio = true
    ..expirationDate = DateTime.fromMillisecondsSinceEpoch(1557701763036)
    ..quantity = 3.1415
    ..numberOfItems = 44
    ..storageTemperature = 106
    ..description = "Happiness forever"
    ..dateCreate = DateTime.fromMillisecondsSinceEpoch(1557701763037)
    ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763038);

  group('ReceiptProxy test', () {
    test('fromMap', () async {
      var receiptFromMap = ReceiptProxy.fromMap(testMap);

      expect(receiptFromMap, TypeMatcher<ReceiptProxy>());
      expect(receiptFromMap.id, receiptProxy.id);
      expect(receiptFromMap.description, receiptProxy.description);
      expect(receiptFromMap.dateCreate, receiptProxy.dateCreate);
      expect(receiptFromMap.dateUpdate, receiptProxy.dateUpdate);
      expect(receiptFromMap.isBio, receiptProxy.isBio);
      expect(receiptFromMap.expirationDate, receiptProxy.expirationDate);
      expect(receiptFromMap.quantity, receiptProxy.quantity);
      expect(receiptFromMap.numberOfItems, receiptProxy.numberOfItems);
      expect(
          receiptFromMap.storageTemperature, receiptProxy.storageTemperature);
    });

    test('toMap', () async {
      var receiptMapFromInstance = receiptProxy.toMap();

      expect(receiptMapFromInstance, testMap);
    });

    test('backAndForthMap', () async {
      var receiptFromMap = ReceiptProxy.fromMap(testMap);
      var receiptToMap = receiptFromMap.toMap();

      expect(receiptToMap, testMap);
    });
  });
}
