import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';
import 'package:test/test.dart';

main() {
  var testMap = {
    "id": 1,
    "description": "Tester John",
    "abbreviation": "JD",
    "email": "john@doe.com",
    "user_name": "John Doe",
    "is_current": 1
  };

  var userAccountProxy = UserAccountProxy()
    ..id = 1
    ..email = "john@doe.com"
    ..abbreviation = "JD"
    ..description = "Tester John"
    ..userName = "John Doe"
    ..isCurrent = true;

  group('UserAccountProxy test', () {
    test('fromMap', () async {
      var userAccountFromMap = UserAccountProxy.fromMap(testMap);

      expect(userAccountFromMap, TypeMatcher<UserAccountProxy>());
      expect(userAccountFromMap.id, userAccountProxy.id);
      expect(userAccountFromMap.description, userAccountProxy.description);
      expect(userAccountFromMap.abbreviation, userAccountProxy.abbreviation);
      expect(userAccountFromMap.email, userAccountProxy.email);
      expect(userAccountFromMap.userName, userAccountProxy.userName);
      expect(userAccountFromMap.isCurrent, userAccountProxy.isCurrent);
    });

    test('toMap', () async {
      var userAccountMapFromInstance = userAccountProxy.toMap();

      expect(userAccountMapFromInstance, testMap);
    });

    test('backAndForthMap', () async {
      var userAccountFromMap = UserAccountProxy.fromMap(testMap);
      var userAccountToMap = userAccountFromMap.toMap();

      expect(userAccountToMap, testMap);
    });
  });
}
