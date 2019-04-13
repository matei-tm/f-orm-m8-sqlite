import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('orm-m8 App', () {
    final textFieldHealthEntryFinder = find.byValueKey('healthEntry');

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

      await driver.enterText("hello");
      await driver.waitFor(find.text('hello'));
    });
  });
}
