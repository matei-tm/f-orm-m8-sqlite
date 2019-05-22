import 'package:sqlite_m8_demo/models/to_do.g.m8.dart';
import 'package:test/test.dart';

main() {
  var testMap = {
    "id": 1,
    "diagnosys_date": 1557701763036,
    "user_account_id": 2,
    "description": "happy",
    "date_create": 1557701763037,
    "date_update": 1557701763038,
    "date_delete": 1557701763039
  };

  var toDoProxy = ToDoProxy()
    ..id = 1
    ..diagnosysDate = DateTime.fromMillisecondsSinceEpoch(1557701763036)
    ..accountId = 2
    ..description = "happy"
    ..dateCreate = DateTime.fromMillisecondsSinceEpoch(
        1557701763037) //"2019-05-13T01:56:03.037"
    ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763038)
    ..dateDelete = DateTime.fromMillisecondsSinceEpoch(1557701763039);

  group('ToDoProxy test', () {
    test('fromMap', () async {
      var toDoFromMap = ToDoProxy.fromMap(testMap);

      expect(toDoFromMap, TypeMatcher<ToDoProxy>());
      expect(toDoFromMap.id, toDoProxy.id);
      expect(toDoFromMap.diagnosysDate, toDoProxy.diagnosysDate);
      expect(toDoFromMap.description, toDoProxy.description);
      expect(toDoFromMap.dateCreate, toDoProxy.dateCreate);
      expect(toDoFromMap.dateUpdate, toDoProxy.dateUpdate);
      expect(toDoFromMap.accountId, toDoProxy.accountId);
    });

    test('toMap', () async {
      var toDoMapFromInstance = toDoProxy.toMap();
      //softdelete stamp
      toDoMapFromInstance.putIfAbsent("date_delete", () => 1557701763039);

      expect(toDoMapFromInstance, testMap);
    });

    test('backAndForthMap', () async {
      var toDoFromMap = ToDoProxy.fromMap(testMap);
      var toDoToMap = toDoFromMap.toMap();
      //softdelete stamp
      toDoToMap.putIfAbsent("date_delete", () => 1557701763039);

      expect(toDoToMap, testMap);
    });

    test('isDeleted', () async {
      expect(toDoProxy.isDeleted, true);
    });
  });
}
