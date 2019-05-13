import 'package:sqlite_m8_demo/models/health_entry.g.m8.dart';
import 'package:test/test.dart';

main() {
  var testMap = {
    "id": 1,
    "diagnosys_date": 1557701763036,
    "account_id": 2,
    "description": "happy",
    "date_create": 1557701763037,
    "date_update": 1557701763038
  };

  var healthEntryProxy = HealthEntryProxy()
    ..id = 1
    ..diagnosysDate = DateTime.fromMillisecondsSinceEpoch(1557701763036)
    ..accountId = 2
    ..description = "happy"
    ..dateCreate = DateTime.fromMillisecondsSinceEpoch(
        1557701763037) //"2019-05-13T01:56:03.037"
    ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763038);

  group('HealthEntryProxy test', () {
    test('fromMap', () async {
      var healthEntryFromMap = HealthEntryProxy.fromMap(testMap);

      expect(healthEntryFromMap, TypeMatcher<HealthEntryProxy>());
      expect(healthEntryFromMap.id, healthEntryProxy.id);
      expect(healthEntryFromMap.diagnosysDate, healthEntryProxy.diagnosysDate);
      expect(healthEntryFromMap.description, healthEntryProxy.description);
      expect(healthEntryFromMap.dateCreate, healthEntryProxy.dateCreate);
      expect(healthEntryFromMap.dateUpdate, healthEntryProxy.dateUpdate);
      expect(healthEntryFromMap.accountId, healthEntryProxy.accountId);
    });

    test('toMap', () async {
      var healthEntryMapFromInstance = healthEntryProxy.toMap();

      expect(healthEntryMapFromInstance, testMap);
    });

    test('backAndForthMap', () async {
      var healthEntryFromMap = HealthEntryProxy.fromMap(testMap);
      var healthEntryToMap = healthEntryFromMap.toMap();

      expect(healthEntryToMap, testMap);
    });
  });
}
