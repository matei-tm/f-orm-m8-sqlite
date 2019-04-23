import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  group('orm-m8 Account Page', () {
    final accountNameTextFormFieldFinder =
        find.byValueKey('accountNameTextFormField');
    final emailTextFormFieldFinder = find.byValueKey('emailTextFormField');
    final abbreviationTextFormFieldFinder =
        find.byValueKey('abbreviationTextFormField');
    final saveAccountButtonFinder = find.byValueKey('saveAccountButton');

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('enter text in User name', () async {
      await driver.waitFor(accountNameTextFormFieldFinder);
      await driver.tap(accountNameTextFormFieldFinder);

      await driver.enterText("John Doe");
      await driver.waitFor(find.text('John Doe'));
    });

    test('enter text in email', () async {
      await driver.waitFor(emailTextFormFieldFinder);
      await driver.tap(emailTextFormFieldFinder);

      await driver.enterText("john@doe.com");
      await driver.waitFor(find.text('john@doe.com'));
    });

    test('enter text in abbreviation', () async {
      await driver.waitFor(abbreviationTextFormFieldFinder);
      await driver.tap(abbreviationTextFormFieldFinder);

      await driver.enterText("JD");
      await driver.waitFor(find.text('JD'));
    });

    test('submit new account', () async {
      await driver.waitFor(saveAccountButtonFinder);
      await driver.tap(saveAccountButtonFinder);
    });
  });
}
