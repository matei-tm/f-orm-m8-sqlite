import 'package:sqlite_m8_demo/models/gym_location.g.m8.dart';
import 'package:test/test.dart';

main() {
  var testMap = {
    "id": 1,
    "description": "silva",
    "rating": 5,
    "date_create": 1557701763037,
    "date_update": 1557701763038
  };

  var gymLocationProxy = GymLocationProxy()
    ..id = 1
    ..dateCreate = DateTime.fromMillisecondsSinceEpoch(
        1557701763037) //"2019-05-13T01:56:03.037"
    ..dateUpdate = DateTime.fromMillisecondsSinceEpoch(1557701763038)
    ..rating = 5
    ..description = "silva";

  group('GymLocationProxy test', () {
    test('fromMap', () async {
      var gymLocationFromMap = GymLocationProxy.fromMap(testMap);

      expect(gymLocationFromMap, TypeMatcher<GymLocationProxy>());
      expect(gymLocationFromMap.id, gymLocationProxy.id);
      expect(gymLocationFromMap.description, gymLocationProxy.description);
      expect(gymLocationFromMap.dateCreate, gymLocationProxy.dateCreate);
      expect(gymLocationFromMap.dateUpdate, gymLocationProxy.dateUpdate);
      expect(gymLocationFromMap.rating, gymLocationProxy.rating);
    });

    test('toMap', () async {
      var gymLocationMapFromInstance = gymLocationProxy.toMap();

      expect(gymLocationMapFromInstance, testMap);
    });

    test('backAndForthMap', () async {
      var gymLocationFromMap = GymLocationProxy.fromMap(testMap);
      var gymLocationToMap = gymLocationFromMap.toMap();

      expect(gymLocationToMap, testMap);
    });
  });
}
