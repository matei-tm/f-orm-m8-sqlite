// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:mockito/mockito.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sqlite_m8_demo/main.dart';
import 'package:sqlite_m8_demo/models/receipt.g.m8.dart';
import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';

import 'utils.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

ReceiptProxy receiptNewProbe = ReceiptProxy.fromMap({
  "id": 1,
  "is_bio": 0,
  "expiration_date":
      DateTime.parse("2061-07-28 17:50:03.000").millisecondsSinceEpoch,
  "quantity": 1.618,
  "number_of_items": 42,
  "storage_temperature": -38.83,
  "description": "Happiness",
  "date_create": DateTime.now().millisecondsSinceEpoch,
  "date_update": DateTime.now().millisecondsSinceEpoch,
});

ReceiptProxy receiptUpdateProbe = ReceiptProxy.fromMap({
  "id": 1,
  "is_bio": 1,
  "expiration_date":
      DateTime.parse("2071-07-28 17:50:03.000").millisecondsSinceEpoch,
  "quantity": 3.1415,
  "number_of_items": 44,
  "storage_temperature": 106,
  "description": "Happiness forever",
  "date_create": DateTime.now().millisecondsSinceEpoch,
  "date_update": DateTime.now().millisecondsSinceEpoch,
});

MockDatabaseHelper buildMockDatabaseAdapter() {
  MockDatabaseHelper mockDatabaseHelper = MockDatabaseHelper();
  mockDatabaseHelper.extremeDevelopmentMode = false;

  enableCurrentUserAccount(mockDatabaseHelper);

  return mockDatabaseHelper;
}

void enableCurrentUserAccount(MockDatabaseHelper mockDatabaseHelper) {
  UserAccountProxy firstUser = UserAccountProxy();
  firstUser.id = 1;
  firstUser.email = "John@Doe.com";
  firstUser.abbreviation = "JD";
  firstUser.description = "Tester John";
  firstUser.userName = "John Doe";
  firstUser.isCurrent = true;

  List<UserAccountProxy> usersList = [firstUser];

  when(mockDatabaseHelper.getCurrentUserAccount())
      .thenAnswer((_) => Future.value(firstUser));
  when(mockDatabaseHelper.extremeDevelopmentMode).thenAnswer((_) => false);
  when(mockDatabaseHelper.getUserAccountProxiesAll())
      .thenAnswer((_) => Future.value(usersList));

  when(mockDatabaseHelper.getReceiptProxiesAll())
      .thenAnswer((_) => Future.value(List<ReceiptProxy>()));

  when(mockDatabaseHelper.saveReceipt(any)).thenAnswer((_) => Future.value(1));

  when(mockDatabaseHelper.getReceipt(1))
      .thenAnswer((_) => Future.value(receiptNewProbe));

  when(mockDatabaseHelper.deleteReceipt(any))
      .thenAnswer((_) => Future.value(1));
}

void main() {
  final MockDatabaseHelper mockDatabaseHelper = buildMockDatabaseAdapter();
  testWidgets('Navigate to Receipts test', (WidgetTester tester) async {
    await navigateToReceipt(tester, mockDatabaseHelper);
  });

  testWidgets('Add new receipt test', (WidgetTester tester) async {
    await navigateToReceipt(tester, mockDatabaseHelper);
    await addNewReceipt(tester, mockDatabaseHelper);
    await fillReceipt(tester, mockDatabaseHelper, receiptNewProbe);
    await saveAndCheckReceipt(tester, mockDatabaseHelper, receiptNewProbe);
  });

  testWidgets('Update receipt test', (WidgetTester tester) async {
    await navigateToReceipt(tester, mockDatabaseHelper);
    await addNewReceipt(tester, mockDatabaseHelper);
    await fillReceipt(tester, mockDatabaseHelper, receiptNewProbe);
    await saveAndCheckReceipt(tester, mockDatabaseHelper, receiptNewProbe);
    await hitUpdateReceipt(tester, mockDatabaseHelper, 1);
    await fillReceipt(tester, mockDatabaseHelper, receiptUpdateProbe);
    await saveAndCheckReceipt(tester, mockDatabaseHelper, receiptUpdateProbe);
  });

  testWidgets('Delete receipt test', (WidgetTester tester) async {
    await navigateToReceipt(tester, mockDatabaseHelper);
    await addNewReceipt(tester, mockDatabaseHelper);
    await fillReceipt(tester, mockDatabaseHelper, receiptNewProbe);
    await saveAndCheckReceipt(tester, mockDatabaseHelper, receiptNewProbe);
    await deleteReceipt(tester, mockDatabaseHelper);
  });
}

Future navigateToReceipt(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseHelper));

  await tester.pump();

  expect(find.text('Gymspector'), findsOneWidget);

  expect(find.byTooltip('Navigation menu'), findsOneWidget);
  await tester.tap(find.byTooltip('Navigation menu'));
  await tester.pumpAndSettle();

  expect(find.byKey(Key('receiptsMenuButton')), findsOneWidget);
  await tester.tap(find.byKey(Key('receiptsMenuButton')));
  await tester.pumpAndSettle();

  expect(find.text('Receipts'), findsOneWidget);
  expect(find.text('Happiness'), findsNothing);
}

Future addNewReceipt(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('addReceiptButton')), findsOneWidget);
  await tester.tap(find.byKey(Key('addReceiptButton')));
  await tester.pumpAndSettle();
  expect(find.text('Add Receipt'), findsOneWidget);
}

Future hitUpdateReceipt(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper, int id) async {
  expect(find.byKey(Key('updBtnReceipt$id')), findsOneWidget);
  await tester.tap(find.byKey(Key('updBtnReceipt$id')));
  await tester.pumpAndSettle();
  expect(find.text('Edit Receipt'), findsOneWidget);
}

Future fillReceipt(WidgetTester tester, MockDatabaseHelper mockDatabaseHelper,
    ReceiptProxy currentReceipt) async {
  final receiptDescriptionTextFieldFinder =
      find.byKey(Key('receiptDescriptionField'));
  final receiptExpirationDateFieldFinder =
      find.byKey(Key('receiptExpirationDateField'));
  final receiptIsBioSwitchFinder = find.byKey(Key('receiptIsBioSwitch'));
  final receiptNumberOfItemsFieldFinder =
      find.byKey(Key('receiptNumberOfItemsField'));
  final receiptQuantityFieldFinder = find.byKey(Key('receiptQuantityField'));
  final receiptStorageTemperatureFieldFinder =
      find.byKey(Key('receiptStorageTemperatureField'));

  expect(receiptDescriptionTextFieldFinder, findsOneWidget);
  await tester.tap(receiptDescriptionTextFieldFinder);
  await tester.pump();

  await tester.enterText(
      receiptDescriptionTextFieldFinder, currentReceipt.description);
  expect(find.text(currentReceipt.description), findsOneWidget);

  expect(receiptExpirationDateFieldFinder, findsOneWidget);
  await tester.tap(receiptExpirationDateFieldFinder);
  await tester.pump();

  await tester.enterText(receiptExpirationDateFieldFinder,
      currentReceipt.expirationDate.toIso8601String());
  expect(find.text(currentReceipt.expirationDate.toIso8601String()),
      findsOneWidget);

  expect(receiptIsBioSwitchFinder, findsOneWidget);

  await tester.tap(receiptIsBioSwitchFinder);
  await tester.pumpAndSettle();
  expect(
      receiptIsBioSwitchFinder, isSwitchListTileToggled(currentReceipt.isBio));

  expect(receiptNumberOfItemsFieldFinder, findsOneWidget);
  await tester.tap(receiptNumberOfItemsFieldFinder);
  await tester.pump();

  await tester.enterText(
      receiptNumberOfItemsFieldFinder, currentReceipt.numberOfItems.toString());
  expect(find.text(currentReceipt.numberOfItems.toString()), findsOneWidget);

  expect(receiptQuantityFieldFinder, findsOneWidget);
  await tester.tap(receiptQuantityFieldFinder);
  await tester.pump();

  await tester.enterText(
      receiptQuantityFieldFinder, "${currentReceipt.quantity}0");
  expect(find.text('${currentReceipt.quantity}0'), findsOneWidget);

  expect(receiptStorageTemperatureFieldFinder, findsOneWidget);
  await tester.tap(receiptStorageTemperatureFieldFinder);
  await tester.pump();

  await tester.enterText(receiptStorageTemperatureFieldFinder,
      "${currentReceipt.storageTemperature}");
  expect(find.text('${currentReceipt.storageTemperature}'), findsOneWidget);
}

Future saveAndCheckReceipt(WidgetTester tester,
    MockDatabaseHelper mockDatabaseHelper, ReceiptProxy currentReceipt) async {
  final saveReceiptButtonFinder = find.byKey(Key('saveReceiptButton'));
  expect(saveReceiptButtonFinder, findsOneWidget);
  await tester.tap(saveReceiptButtonFinder);
  await tester.pumpAndSettle();

  expect(find.text('${currentReceipt.description}'), findsOneWidget);

  expect(find.text('Expiration Date: ${currentReceipt.expirationDate}'),
      findsOneWidget);

  expect(find.text('Is Bio: ${currentReceipt.isBio}'), findsOneWidget);
  expect(find.text('Number of Items: ${currentReceipt.numberOfItems}'),
      findsOneWidget);

  expect(find.text('Quantity: ${currentReceipt.quantity}'), findsOneWidget);
  expect(
      find.text(
          'Storage Temperature: ${currentReceipt.storageTemperature}\u00b0'),
      findsOneWidget);
}

Future deleteReceipt(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('delBtnReceipt1')), findsOneWidget);

  await tester.tap(find.byKey(Key('delBtnReceipt1')));
  await tester.pumpAndSettle();
}
