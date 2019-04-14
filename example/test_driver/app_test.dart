import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('orm-m8 App', () {
    final textFieldHealthEntryFinder = find.byValueKey('healthEntry');
    final addButtonFinder = find.byValueKey('addButton');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('enter text in TextField', () async {
      await driver.waitFor(textFieldHealthEntryFinder);
      await driver.tap(textFieldHealthEntryFinder);

      await driver.enterText("happy");
      await driver.waitFor(find.text('happy'));
    });

    test('add new health entry', () async {
      await driver.waitFor(textFieldHealthEntryFinder);
      await driver.tap(textFieldHealthEntryFinder);

      await driver.enterText("happy", timeout: Duration(seconds: 1));
      await driver.waitFor(find.text('happy'));

      await driver.waitFor(addButtonFinder);
      await driver.tap(addButtonFinder);
    });

    test('delete health entry', () async {
      var delButtonFinder = find.byValueKey('delBtnHealth1');

      await driver.waitFor(delButtonFinder);
      await driver.tap(delButtonFinder);
    });

    test('add same health entry twice', () async {
      await driver.waitFor(textFieldHealthEntryFinder);
      await driver.tap(textFieldHealthEntryFinder);

      await driver.enterText("happy", timeout: Duration(seconds: 1));
      await driver.waitFor(find.text('happy'));

      await driver.waitFor(addButtonFinder);
      await driver.tap(addButtonFinder);

      await driver.enterText("happy", timeout: Duration(seconds: 1));
      await driver.waitFor(find.text('happy'));

      await driver.waitFor(addButtonFinder);
      await driver.tap(addButtonFinder);

      await driver.waitFor(find.byValueKey('errorSnack'));

      var delButtonFinder = find.byValueKey('delBtnHealth2');
      await driver.waitFor(delButtonFinder);
      await driver.tap(delButtonFinder);
    });
  });
}
