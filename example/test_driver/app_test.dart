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
    final addNewAccountButtonFinder = find.byValueKey('addNewAccountButton');
    final deleteAccountButtonFinder = find.byValueKey('deleteAccountButton');

    final cancelDeleteAccountButtonFinder =
        find.byValueKey('cancelDeleteAccount');
    final confirmDeleteAccountButtonFinder =
        find.byValueKey('confirmDeleteAccount');
    final cancelAddingAccountButtonFinder =
        find.byValueKey('cancelAddingAccount');
    final confirmAddingAccountButtonFinder =
        find.byValueKey('confirmAddingAccount');

    final SerializableFinder drawerOpenButton =
        find.byTooltip('Navigation menu');
    final userAccountMenuButtonFinder =
        find.byValueKey('userAccountMenuButton');

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

    test('open drawer and tap User Account', () async {
      await driver.tap(drawerOpenButton);

      await driver.waitFor(userAccountMenuButtonFinder);
      await driver.tap(userAccountMenuButtonFinder);
    });

    test('edit User account', () async {
      await driver.waitFor(accountNameTextFormFieldFinder);
      await driver.tap(accountNameTextFormFieldFinder);

      await driver.enterText("John Nash");
      await driver.waitFor(find.text('John Nash'));

      await driver.waitFor(emailTextFormFieldFinder);
      await driver.tap(emailTextFormFieldFinder);

      await driver.enterText("john@nash.com");
      await driver.waitFor(find.text('john@nash.com'));

      await driver.waitFor(abbreviationTextFormFieldFinder);
      await driver.tap(abbreviationTextFormFieldFinder);

      await driver.enterText("JN");
      await driver.waitFor(find.text('JN'));

      await driver.waitFor(saveAccountButtonFinder);
      await driver.tap(saveAccountButtonFinder);
    });

    test('add second User account', () async {
      await driver.tap(drawerOpenButton);

      await driver.waitFor(find.text('john@nash.com'));

      await driver.waitFor(userAccountMenuButtonFinder);
      await driver.tap(userAccountMenuButtonFinder);

      await driver.waitFor(addNewAccountButtonFinder);
      await driver.tap(addNewAccountButtonFinder);

      await driver.waitFor(cancelAddingAccountButtonFinder);
      await driver.tap(cancelAddingAccountButtonFinder);

      await driver.waitFor(addNewAccountButtonFinder);
      await driver.tap(addNewAccountButtonFinder);

      await driver.waitFor(confirmAddingAccountButtonFinder);
      await driver.tap(confirmAddingAccountButtonFinder);

      await driver.waitFor(accountNameTextFormFieldFinder);
      await driver.tap(accountNameTextFormFieldFinder);

      await driver.enterText("Julius Axelrod");
      await driver.waitFor(find.text('Julius Axelrod'));

      await driver.waitFor(emailTextFormFieldFinder);
      await driver.tap(emailTextFormFieldFinder);

      await driver.enterText("julius@axelrod.com");
      await driver.waitFor(find.text('julius@axelrod.com'));

      await driver.waitFor(abbreviationTextFormFieldFinder);
      await driver.tap(abbreviationTextFormFieldFinder);

      await driver.enterText("JA");
      await driver.waitFor(find.text('JA'));

      await driver.waitFor(saveAccountButtonFinder);
      await driver.tap(saveAccountButtonFinder);
    });

    test('add third User account', () async {
      await driver.tap(drawerOpenButton);

      await driver.waitFor(find.text('julius@axelrod.com'));

      await driver.waitFor(userAccountMenuButtonFinder);
      await driver.tap(userAccountMenuButtonFinder);

      await driver.waitFor(addNewAccountButtonFinder);
      await driver.tap(addNewAccountButtonFinder);

      await driver.waitFor(confirmAddingAccountButtonFinder);
      await driver.tap(confirmAddingAccountButtonFinder);

      await driver.waitFor(accountNameTextFormFieldFinder);
      await driver.tap(accountNameTextFormFieldFinder);

      await driver.enterText("Mircea Matei");
      await driver.waitFor(find.text('Mircea Matei'));

      await driver.waitFor(emailTextFormFieldFinder);
      await driver.tap(emailTextFormFieldFinder);

      await driver.enterText("mircea@matei-tm.eu");
      await driver.waitFor(find.text('mircea@matei-tm.eu'));

      await driver.waitFor(abbreviationTextFormFieldFinder);
      await driver.tap(abbreviationTextFormFieldFinder);

      await driver.enterText("MM");
      await driver.waitFor(find.text('MM'));

      await driver.waitFor(saveAccountButtonFinder);
      await driver.tap(saveAccountButtonFinder);
    });

    test('switch to second User account', () async {
      await driver.tap(drawerOpenButton);
      final accountAvatar2Finder = find.byValueKey('accountAvatar2');

      await driver.waitFor(accountAvatar2Finder);
      await driver.tap(accountAvatar2Finder);
      final confirmSwitchingAccountFinder =
          find.byValueKey('confirmSwitchingAccount');

      await driver.waitFor(confirmSwitchingAccountFinder);
      await driver.tap(confirmSwitchingAccountFinder);
    });

    test('delete second User account', () async {
      await driver.tap(drawerOpenButton);

      await driver.waitFor(find.text('julius@axelrod.com'));

      await driver.waitFor(userAccountMenuButtonFinder);
      await driver.tap(userAccountMenuButtonFinder);

      await driver.waitFor(deleteAccountButtonFinder);
      await driver.tap(deleteAccountButtonFinder);

      await driver.waitFor(cancelDeleteAccountButtonFinder);
      await driver.tap(cancelDeleteAccountButtonFinder);

      await driver.waitFor(deleteAccountButtonFinder);
      await driver.tap(deleteAccountButtonFinder);

      await driver.waitFor(confirmDeleteAccountButtonFinder);
      await driver.tap(confirmDeleteAccountButtonFinder);
    });
  });
  group('orm-m8 Health Page', () {
    final SerializableFinder drawerOpenButton =
        find.byTooltip('Navigation menu');
    final healthRecordsMenuButtonFinder =
        find.byValueKey('healthRecordsMenuButton');
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
      await driver.tap(drawerOpenButton);

      await driver.waitFor(healthRecordsMenuButtonFinder);
      await driver.tap(healthRecordsMenuButtonFinder);
      await driver.checkHealth(timeout: const Duration(milliseconds: 3000));
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

    test('enter Happy text again and check unique constraint', () async {
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

  group('orm-m8 Gym Places Page', () {
    final SerializableFinder drawerOpenButton =
        find.byTooltip('Navigation menu');
    final gymPlacesMenuButtonFinder = find.byValueKey('gymPlacesMenuButton');
    final gymPlaceTextFieldFinder = find.byValueKey('gymLocation');
    final addGymPlaceButtonFinder = find.byValueKey('addGymPlaceButton');
    final deleteGymPlace03ButtonFinder = find.byValueKey('delBtnGymPlace3');

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('open drawer and tap Gym Places', () async {
      await driver.tap(drawerOpenButton);

      await driver.waitFor(gymPlacesMenuButtonFinder);
      await driver.tap(gymPlacesMenuButtonFinder);

      await driver.checkHealth(timeout: const Duration(milliseconds: 3000));
    });

    test('enter Forum text in Gym Place entry and save', () async {
      await driver.waitFor(gymPlaceTextFieldFinder);
      await driver.tap(gymPlaceTextFieldFinder);

      await driver.enterText("Forum");
      await driver.waitFor(find.text('Forum'));

      await driver.waitFor(addGymPlaceButtonFinder);
      await driver.tap(addGymPlaceButtonFinder);

      await driver.waitFor(find.text('Forum'));
    });

    test('enter Forum text again and check unique constraint', () async {
      await driver.waitFor(gymPlaceTextFieldFinder);
      await driver.tap(gymPlaceTextFieldFinder);

      await driver.enterText("Forum");
      await driver.waitFor(find.text('Forum'));

      await driver.waitFor(addGymPlaceButtonFinder);
      await driver.tap(addGymPlaceButtonFinder);

      await driver.waitFor(find.text('Error:'));
    });

    test('enter Silva text in Gym Place entry and save', () async {
      await driver.waitFor(gymPlaceTextFieldFinder);
      await driver.tap(gymPlaceTextFieldFinder);

      await driver.enterText("Silva");
      await driver.waitFor(find.text('Silva'));

      await driver.waitFor(addGymPlaceButtonFinder);
      await driver.tap(addGymPlaceButtonFinder);

      await driver.waitFor(find.text('Silva'));
    });

    test('enter Rubicon text in Gym Place entry, save and delete', () async {
      await driver.waitFor(gymPlaceTextFieldFinder);
      await driver.tap(gymPlaceTextFieldFinder);

      await driver.enterText("Rubicon");
      await driver.waitFor(find.text('Rubicon'));

      await driver.waitFor(addGymPlaceButtonFinder);
      await driver.tap(addGymPlaceButtonFinder);

      await driver.waitFor(find.text('Rubicon'));

      await driver.waitFor(deleteGymPlace03ButtonFinder);
      await driver.tap(deleteGymPlace03ButtonFinder);
    });

    test('enter Montis text in Gym Place entry and save', () async {
      await driver.waitFor(gymPlaceTextFieldFinder);
      await driver.tap(gymPlaceTextFieldFinder);

      await driver.enterText("Montis");
      await driver.waitFor(find.text('Montis'));

      await driver.waitFor(addGymPlaceButtonFinder);
      await driver.tap(addGymPlaceButtonFinder);

      await driver.waitFor(find.text('Montis'));
    });
  });

  group('orm-m8 Receipt Page', () {
    final SerializableFinder drawerOpenButton =
        find.byTooltip('Navigation menu');
    final gymPlacesMenuButtonFinder = find.byValueKey('receiptsMenuButton');

    final addReceiptButtonFinder = find.byValueKey('addReceiptButton');
    final saveReceiptButtonFinder = find.byValueKey('saveReceiptButton');
    final updateReceipt01ButtonFinder = find.byValueKey('updBtnReceipt1');
    final deleteReceipt02ButtonFinder = find.byValueKey('delBtnReceipt2');
    final cancelDeleteReceiptButtonFinder =
        find.byValueKey('cancelDeleteReceiptButton');
    final confirmDeleteReceiptButtonFinder =
        find.byValueKey('confirmDeleteReceiptButton');

    final receiptDescriptionTextFieldFinder =
        find.byValueKey('receiptDescriptionField');
    final receiptExpirationDateFieldFinder =
        find.byValueKey('receiptExpirationDateField');
    final receiptIsBioSwitchFinder = find.byValueKey('receiptIsBioSwitch');
    final receiptNumberOfItemsFieldFinder =
        find.byValueKey('receiptNumberOfItemsField');
    final receiptQuantityFieldFinder = find.byValueKey('receiptQuantityField');
    final receiptStorageTemperatureFieldFinder =
        find.byValueKey('receiptStorageTemperatureField');
    final receiptNumberOfMoleculesFieldFinder =
        find.byValueKey('receiptNumberOfMoleculesField');
    final receiptDecompositionDurationFieldFinder =
        find.byValueKey('receiptDecompositionDurationField');

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('open drawer and tap Receipts', () async {
      await driver.tap(drawerOpenButton);

      await driver.waitFor(gymPlacesMenuButtonFinder);
      await driver.tap(gymPlacesMenuButtonFinder);

      await driver.checkHealth(timeout: const Duration(milliseconds: 3000));
    });

    test('add new receipt', () async {
      await driver.waitFor(addReceiptButtonFinder);
      await driver.tap(addReceiptButtonFinder);
    });

    test('fill Happiness receipt and save', () async {
      await driver.waitFor(receiptDescriptionTextFieldFinder);
      await driver.tap(receiptDescriptionTextFieldFinder);

      await driver.enterText("Happiness");
      await driver.waitFor(find.text('Happiness'));

      await driver.waitFor(receiptDecompositionDurationFieldFinder);
      await driver.tap(receiptDecompositionDurationFieldFinder);

      await driver.enterText("123456789");
      await driver.waitFor(find.text('123456789'));

      await driver.waitFor(receiptExpirationDateFieldFinder);
      await driver.tap(receiptExpirationDateFieldFinder);

      await driver.enterText("2061-07-28 17:50:03");
      await driver.waitFor(find.text('2061-07-28 17:50:03'));

      await driver.waitFor(receiptIsBioSwitchFinder);
      await driver.tap(receiptIsBioSwitchFinder);

      await driver.waitFor(receiptNumberOfItemsFieldFinder);
      await driver.tap(receiptNumberOfItemsFieldFinder);

      await driver.enterText("42");
      await driver.waitFor(find.text('42'));

      await driver.waitFor(receiptNumberOfMoleculesFieldFinder);
      await driver.tap(receiptNumberOfMoleculesFieldFinder);

      await driver.enterText("987654321");
      await driver.waitFor(find.text('987654321'));

      await driver.waitFor(receiptQuantityFieldFinder);
      await driver.tap(receiptQuantityFieldFinder);

      await driver.enterText("1.6180");
      await driver.waitFor(find.text('1.6180'));

      await driver.waitFor(receiptStorageTemperatureFieldFinder);
      await driver.tap(receiptStorageTemperatureFieldFinder);

      await driver.enterText("-38.83");
      await driver.waitFor(find.text('-38.83'));

      await driver.waitFor(saveReceiptButtonFinder);
      await driver.tap(saveReceiptButtonFinder);

      await driver.waitFor(find.text('Happiness'));
      await driver
          .waitFor(find.text('Expiration Date: 2061-07-28 17:50:03.000'));
      await driver.waitFor(find.text('Is Bio: false'));
      await driver.waitFor(find.text('Number of Items: 42'));
      await driver.waitFor(find.text('Quantity: 1.618'));
      await driver.waitFor(find.text('Storage Temperature: -38.83\u00b0'));
      await Future<void>.delayed(const Duration(milliseconds: 500));
    });

    test('tap update Happiness receipt', () async {
      await driver.waitFor(updateReceipt01ButtonFinder);
      await driver.tap(updateReceipt01ButtonFinder);
    });

    test('change Happiness receipt and save', () async {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      await driver.waitFor(receiptDescriptionTextFieldFinder);
      await driver.tap(receiptDescriptionTextFieldFinder);

      await driver.enterText("Happiness forever");
      await driver.waitFor(find.text('Happiness forever'));

      await driver.waitFor(receiptDecompositionDurationFieldFinder);
      await driver.tap(receiptDecompositionDurationFieldFinder);

      await driver.enterText("123000789");
      await driver.waitFor(find.text('123000789'));

      await driver.waitFor(receiptExpirationDateFieldFinder);
      await driver.tap(receiptExpirationDateFieldFinder);

      await driver.enterText("2071-05-30 18:59:01");
      await driver.waitFor(find.text('2071-05-30 18:59:01'));

      await driver.waitFor(receiptIsBioSwitchFinder);
      await driver.tap(receiptIsBioSwitchFinder);

      await driver.waitFor(receiptNumberOfItemsFieldFinder);
      await driver.tap(receiptNumberOfItemsFieldFinder);

      await driver.enterText("52");
      await driver.waitFor(find.text('52'));

      await driver.waitFor(receiptNumberOfMoleculesFieldFinder);
      await driver.tap(receiptNumberOfMoleculesFieldFinder);

      await driver.enterText("987000321");
      await driver.waitFor(find.text('987000321'));

      await driver.waitFor(receiptQuantityFieldFinder);
      await driver.tap(receiptQuantityFieldFinder);

      await driver.enterText("3.141592");
      await driver.waitFor(find.text('3.141592'));

      await driver.waitFor(receiptStorageTemperatureFieldFinder);
      await driver.tap(receiptStorageTemperatureFieldFinder);

      await driver.enterText("1063");
      await driver.waitFor(find.text('1063'));

      await driver.waitFor(saveReceiptButtonFinder);
      await driver.tap(saveReceiptButtonFinder);

      await driver.waitFor(find.text('Happiness forever'));
      await driver
          .waitFor(find.text('Expiration Date: 2071-05-30 18:59:01.000'));
      await driver.waitFor(find.text('Is Bio: true'));
      await driver.waitFor(find.text('Number of Items: 52'));
      await driver.waitFor(find.text('Quantity: 3.141592'));
      await driver.waitFor(find.text('Storage Temperature: 1063\u00b0'));
      await driver.checkHealth(timeout: const Duration(milliseconds: 3000));
    });

    test('add new receipt', () async {
      await Future<void>.delayed(const Duration(milliseconds: 5000));
      await driver.waitFor(addReceiptButtonFinder);
      await driver.tap(addReceiptButtonFinder);
    });

    test('fill Joy receipt and save', () async {
      await driver.waitFor(receiptDescriptionTextFieldFinder);
      await driver.tap(receiptDescriptionTextFieldFinder);

      await driver.enterText("Joy");
      await driver.waitFor(find.text('Joy'));

      await driver.waitFor(receiptDecompositionDurationFieldFinder);
      await driver.tap(receiptDecompositionDurationFieldFinder);

      await driver.enterText("44444444");
      await driver.waitFor(find.text('44444444'));

      await driver.waitFor(receiptExpirationDateFieldFinder);
      await driver.tap(receiptExpirationDateFieldFinder);

      await driver.enterText("2019-05-30 17:50:03.123");
      await driver.waitFor(find.text('2019-05-30 17:50:03.123'));

      await driver.waitFor(receiptNumberOfItemsFieldFinder);
      await driver.tap(receiptNumberOfItemsFieldFinder);

      await driver.enterText("34866");
      await driver.waitFor(find.text('34866'));

      await driver.waitFor(receiptNumberOfMoleculesFieldFinder);
      await driver.tap(receiptNumberOfMoleculesFieldFinder);

      await driver.enterText("88888888");
      await driver.waitFor(find.text('88888888'));

      await driver.waitFor(receiptQuantityFieldFinder);
      await driver.tap(receiptQuantityFieldFinder);

      await driver.enterText("2.71828");
      await driver.waitFor(find.text('2.71828'));

      await driver.waitFor(receiptStorageTemperatureFieldFinder);
      await driver.tap(receiptStorageTemperatureFieldFinder);

      await driver.enterText("-273.15");
      await driver.waitFor(find.text('-273.15'));

      await driver.waitFor(saveReceiptButtonFinder);
      await driver.tap(saveReceiptButtonFinder);

      await driver.waitFor(find.text('Joy'));
      await driver
          .waitFor(find.text('Expiration Date: 2019-05-30 17:50:03.123'));
      await driver.waitFor(find.text('Is Bio: true'));
      await driver.waitFor(find.text('Number of Items: 34866'));
      await driver.waitFor(find.text('Quantity: 2.71828'));
      await driver.waitFor(find.text('Storage Temperature: -273.15\u00b0'));
      await Future<void>.delayed(const Duration(milliseconds: 500));
    });

    test('try delete Joy receipt with cancel', () async {
      await driver.waitFor(deleteReceipt02ButtonFinder);
      await driver.scrollIntoView(deleteReceipt02ButtonFinder);
      await driver.tap(deleteReceipt02ButtonFinder);

      await driver.waitFor(cancelDeleteReceiptButtonFinder);
      await driver.tap(cancelDeleteReceiptButtonFinder);
    });

    test('delete Joy receipt with confirm', () async {
      await driver.waitFor(deleteReceipt02ButtonFinder);
      await driver.scrollIntoView(deleteReceipt02ButtonFinder);
      await driver.tap(deleteReceipt02ButtonFinder);

      await driver.waitFor(confirmDeleteReceiptButtonFinder);
      await driver.tap(confirmDeleteReceiptButtonFinder);
      await Future<void>.delayed(const Duration(milliseconds: 5000));
    });
  });
}
