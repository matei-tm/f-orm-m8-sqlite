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
  group('orm-m8 Health Page', () {
    final healthEntryTextFieldFinder = find.byValueKey('healthEntry');
    final addHealthEntryButtonFinder = find.byValueKey('addHealthEntryButton');
    final deleteHealthEntry03ButtonFinder = find.byValueKey('delBtnHealth3');
    
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('open drawer and tap Health Records', () async {
      final SerializableFinder drawerOpenButton =
          find.byTooltip('Navigation menu');

      await driver.tap(drawerOpenButton);
      final healthRecordsMenuButtonFinder =
          find.byValueKey('healthRecordsMenuButton');
      await driver.waitFor(healthRecordsMenuButtonFinder);
      await driver.tap(healthRecordsMenuButtonFinder);

      final SerializableFinder app = find.byValueKey('OrmM8Example');
      await driver.checkHealth(timeout: const Duration(milliseconds: 3000));
      await driver.scroll(app, -300.0, 0.0, const Duration(milliseconds: 300));
    });

    test('enter Happy text in Health entry and save', () async {
      await driver.waitFor(healthEntryTextFieldFinder);
      await driver.tap(healthEntryTextFieldFinder);

      await driver.enterText("Happy");
      await driver.waitFor(find.text('Happy'));

      await driver.waitFor(addHealthEntryButtonFinder);
      await driver.tap(addHealthEntryButtonFinder);

      await driver.waitFor(find.text('Happy'));
    });

    test('enter Happy text again entry and check unique constraint', () async {
      await driver.waitFor(healthEntryTextFieldFinder);
      await driver.tap(healthEntryTextFieldFinder);

      await driver.enterText("Happy");
      await driver.waitFor(find.text('Happy'));

      await driver.waitFor(addHealthEntryButtonFinder);
      await driver.tap(addHealthEntryButtonFinder);

      await driver.waitFor(find.text('Error:'));
    });

    test('enter Healthy text in Health entry and save', () async {
      await driver.waitFor(healthEntryTextFieldFinder);
      await driver.tap(healthEntryTextFieldFinder);

      await driver.enterText("Healthy");
      await driver.waitFor(find.text('Healthy'));

      await driver.waitFor(addHealthEntryButtonFinder);
      await driver.tap(addHealthEntryButtonFinder);

      await driver.waitFor(find.text('Healthy'));
    });

    test('enter Heavy text in Health entry, save and delete', () async {
      await driver.waitFor(healthEntryTextFieldFinder);
      await driver.tap(healthEntryTextFieldFinder);

      await driver.enterText("Heavy");
      await driver.waitFor(find.text('Heavy'));

      await driver.waitFor(addHealthEntryButtonFinder);
      await driver.tap(addHealthEntryButtonFinder);

      await driver.waitFor(find.text('Heavy'));      
      
      await driver.waitFor(deleteHealthEntry03ButtonFinder);
      await driver.tap(deleteHealthEntry03ButtonFinder);
    });
  });
}
