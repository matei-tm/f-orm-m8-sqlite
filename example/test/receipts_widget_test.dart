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
import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

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
      .thenAnswer((_) => Future.value([]));

  when(mockDatabaseHelper.saveReceipt(any)).thenAnswer((_) => Future.value(1));

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
  final saveReceiptButtonFinder = find.byKey(Key('saveReceiptButton'));

  expect(find.text('Add Receipt'), findsOneWidget);

  expect(receiptDescriptionTextFieldFinder, findsOneWidget);
  await tester.tap(receiptDescriptionTextFieldFinder);
  await tester.pump();

  await tester.enterText(receiptDescriptionTextFieldFinder, "Happiness");
  expect(find.text('Happiness'), findsOneWidget);

  expect(receiptExpirationDateFieldFinder, findsOneWidget);
  await tester.tap(receiptExpirationDateFieldFinder);
  await tester.pump();

  await tester.enterText(
      receiptExpirationDateFieldFinder, "2061-07-28 17:50:03");
  expect(find.text('2061-07-28 17:50:03'), findsOneWidget);

  expect(receiptIsBioSwitchFinder, findsOneWidget);
  await tester.tap(receiptIsBioSwitchFinder);
  await tester.pump();

  expect(receiptNumberOfItemsFieldFinder, findsOneWidget);
  await tester.tap(receiptNumberOfItemsFieldFinder);
  await tester.pump();

  await tester.enterText(receiptNumberOfItemsFieldFinder, "42");
  expect(find.text('42'), findsOneWidget);

  expect(receiptQuantityFieldFinder, findsOneWidget);
  await tester.tap(receiptQuantityFieldFinder);
  await tester.pump();

  await tester.enterText(receiptQuantityFieldFinder, "1.6180");
  expect(find.text('1.6180'), findsOneWidget);

  expect(receiptStorageTemperatureFieldFinder, findsOneWidget);
  await tester.tap(receiptStorageTemperatureFieldFinder);
  await tester.pump();

  await tester.enterText(receiptStorageTemperatureFieldFinder, "-38.83");
  expect(find.text('-38.83'), findsOneWidget);

  expect(saveReceiptButtonFinder, findsOneWidget);
  await tester.tap(saveReceiptButtonFinder);
  await tester.pumpAndSettle();

  expect(find.text('Happiness'), findsOneWidget);

  expect(find.text('Expiration Date: 2061-07-28 17:50:03.000'), findsOneWidget);
  expect(find.text('Is Bio: false'), findsOneWidget);
  expect(find.text('Number of Items: 42'), findsOneWidget);

  //find truncated text
  expect(find.text('Quantity: 1.618'), findsOneWidget);
  expect(find.text('Storage Temperature: -38.83\u00b0'), findsOneWidget);
}
