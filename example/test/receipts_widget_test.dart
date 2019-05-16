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

import 'utils/sample_repo.dart';
import 'utils/toggle_checker.dart';

class MockDatabaseProvider extends Mock implements DatabaseProvider {
  MockDatabaseProvider(InitMode testingMockDb);
}

MockDatabaseProvider buildMockDatabaseAdapter() {
  MockDatabaseProvider mockDatabaseProvider =
      MockDatabaseProvider(InitMode.testingMockDb);

  enableCurrentUserAccount(mockDatabaseProvider);

  return mockDatabaseProvider;
}

void enableCurrentUserAccount(MockDatabaseProvider mockDatabaseProvider) {
  UserAccountProxy firstUser = UserAccountProxy();
  firstUser.id = 1;
  firstUser.email = "John@Doe.com";
  firstUser.abbreviation = "JD";
  firstUser.description = "Tester John";
  firstUser.userName = "John Doe";
  firstUser.isCurrent = true;

  List<UserAccountProxy> usersList = [firstUser];

  when(mockDatabaseProvider.getCurrentUserAccount())
      .thenAnswer((_) => Future.value(firstUser));

  when(mockDatabaseProvider.getUserAccountProxiesAll())
      .thenAnswer((_) => Future.value(usersList));

  when(mockDatabaseProvider.getReceiptProxiesAll())
      .thenAnswer((_) => Future.value(List<ReceiptProxy>()));

  when(mockDatabaseProvider.saveReceipt(any))
      .thenAnswer((_) => Future.value(1));

  when(mockDatabaseProvider.getReceipt(1))
      .thenAnswer((_) => Future.value(receiptNewProbe));

  when(mockDatabaseProvider.deleteReceipt(any))
      .thenAnswer((_) => Future.value(1));
}

void main() {
  final MockDatabaseProvider mockDatabaseProvider = buildMockDatabaseAdapter();
  testWidgets('Navigate to Receipts test', (WidgetTester tester) async {
    await navigateToReceipt(tester, mockDatabaseProvider);
  });

  testWidgets('Add new receipt test', (WidgetTester tester) async {
    await navigateToReceiptAddFillSaveCheck(tester, mockDatabaseProvider);
  });

  testWidgets('Update receipt test', (WidgetTester tester) async {
    await navigateToReceiptAddFillSaveCheck(tester, mockDatabaseProvider);
    await hitUpdateReceipt(tester, mockDatabaseProvider, 1);
    await fillReceipt(tester, mockDatabaseProvider, receiptUpdateProbe);
    await saveAndCheckReceipt(tester, mockDatabaseProvider, receiptUpdateProbe);
  });

  testWidgets('Tap Delete receipt test', (WidgetTester tester) async {
    await navigateToReceiptAddFillSaveCheck(tester, mockDatabaseProvider);
    await tapDeleteReceipt(tester, mockDatabaseProvider);
  });

  testWidgets('Tap Delete receipt and Confirm test',
      (WidgetTester tester) async {
    await navigateToReceiptAddFillSaveCheck(tester, mockDatabaseProvider);
    await tapDeleteReceipt(tester, mockDatabaseProvider);
    await confirmDeleteReceipt(tester, mockDatabaseProvider);
  });

  testWidgets('Tap Delete receipt and Cancel test',
      (WidgetTester tester) async {
    await navigateToReceiptAddFillSaveCheck(tester, mockDatabaseProvider);
    await tapDeleteReceipt(tester, mockDatabaseProvider);
    await cancelDeleteReceipt(tester, mockDatabaseProvider);
  });
}

Future navigateToReceiptAddFillSaveCheck(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  await navigateToReceipt(tester, mockDatabaseProvider);
  await addNewReceipt(tester, mockDatabaseProvider);
  await fillReceipt(tester, mockDatabaseProvider, receiptNewProbe);
  await saveAndCheckReceipt(tester, mockDatabaseProvider, receiptNewProbe);
}

Future navigateToReceipt(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseProvider));

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
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  expect(find.byKey(Key('addReceiptButton')), findsOneWidget);
  await tester.tap(find.byKey(Key('addReceiptButton')));
  await tester.pumpAndSettle();
  expect(find.text('Add Receipt'), findsOneWidget);
}

Future hitUpdateReceipt(WidgetTester tester,
    MockDatabaseProvider mockDatabaseProvider, int id) async {
  expect(find.byKey(Key('updBtnReceipt$id')), findsOneWidget);
  await tester.tap(find.byKey(Key('updBtnReceipt$id')));
  await tester.pumpAndSettle();
  expect(find.text('Edit Receipt'), findsOneWidget);
}

Future fillReceipt(
    WidgetTester tester,
    MockDatabaseProvider mockDatabaseProvider,
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
  final receiptNumberOfMoleculesFieldFinder =
      find.byKey(Key('receiptNumberOfMoleculesField'));
  final receiptDecompositionDurationFieldFinder =
      find.byKey(Key('receiptDecompositionDurationField'));

  expect(receiptDescriptionTextFieldFinder, findsOneWidget);
  await tester.tap(receiptDescriptionTextFieldFinder);
  await tester.pump();

  await tester.enterText(
      receiptDescriptionTextFieldFinder, currentReceipt.description);
  expect(find.text(currentReceipt.description), findsOneWidget);

  await tester.tap(receiptNumberOfMoleculesFieldFinder);
  await tester.pump();

  await tester.enterText(receiptNumberOfMoleculesFieldFinder,
      currentReceipt.numberOfMolecules.toString());
  expect(
      find.text(currentReceipt.numberOfMolecules.toString()), findsOneWidget);

  await tester.tap(receiptDecompositionDurationFieldFinder);
  await tester.pump();

  await tester.enterText(receiptDecompositionDurationFieldFinder,
      currentReceipt.decomposingDuration.inMilliseconds.toString());
  expect(
      find.text(currentReceipt.decomposingDuration.inMilliseconds.toString()),
      findsOneWidget);

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

Future saveAndCheckReceipt(
    WidgetTester tester,
    MockDatabaseProvider mockDatabaseProvider,
    ReceiptProxy currentReceipt) async {
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

Future tapDeleteReceipt(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  expect(find.byKey(Key('delBtnReceipt1')), findsOneWidget);

  await tester.tap(find.byKey(Key('delBtnReceipt1')));
  await tester.pumpAndSettle();
}

Future confirmDeleteReceipt(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  expect(find.byKey(Key('confirmDeleteReceiptButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('confirmDeleteReceiptButton')));
  await tester.pumpAndSettle();

  expect(find.byKey(Key('infoSnack')), findsOneWidget);
}

Future cancelDeleteReceipt(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  expect(find.byKey(Key('cancelDeleteReceiptButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('cancelDeleteReceiptButton')));
  await tester.pumpAndSettle();
}
