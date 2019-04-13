import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('orm-m8 App', () {
    final textFieldHealthEntryFinder = find.byValueKey('textFormField');
    final buttonFinder = find.byValueKey('button');

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

      await driver.waitFor(buttonFinder);
      await driver.tap(buttonFinder);

      await driver.waitFor(textFieldHealthEntryFinder);
      await driver.enterText('young',
          timeout: Duration(seconds: 1));
      await driver.waitFor(find.text('young'));
    });
  });
}
