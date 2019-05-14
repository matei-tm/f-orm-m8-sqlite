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
import 'package:sqlite_m8_demo/models/health_entry.g.m8.dart';
import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {
  MockDatabaseHelper(InitMode testingMockDb);
}

MockDatabaseHelper buildMockDatabaseAdapter() {
  MockDatabaseHelper mockDatabaseHelper =
      MockDatabaseHelper(InitMode.testingMockDb);

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
  //when(mockDatabaseHelper.extremeDevelopmentMode).thenAnswer((_) => false);
  when(mockDatabaseHelper.getUserAccountProxiesAll())
      .thenAnswer((_) => Future.value(usersList));

  when(mockDatabaseHelper.getHealthEntryProxiesByAccountId(1))
      .thenAnswer((_) => Future.value(List<HealthEntryProxy>()));

  when(mockDatabaseHelper.saveHealthEntry(any))
      .thenAnswer((_) => Future.value(1));

  when(mockDatabaseHelper.deleteHealthEntry(any))
      .thenAnswer((_) => Future.value(1));
}

void enableThrowOnDeleteHealthEntry(MockDatabaseHelper mockDatabaseHelper) {
  when(mockDatabaseHelper.deleteHealthEntry(any))
      .thenThrow(Exception("Invalid database. Could not delete"));
}

void main() {
  MockDatabaseHelper mockDatabaseHelper = buildMockDatabaseAdapter();
  testWidgets('Navigate to health entry test', (WidgetTester tester) async {
    await navigateToHealthEntries(tester, mockDatabaseHelper);
  });

  testWidgets('Add valid Health Entry and delete test',
      (WidgetTester tester) async {
    await navigateToHealthEntries(tester, mockDatabaseHelper);
    await healthEntryFillAndSave(tester, mockDatabaseHelper, findsOneWidget);
    await expectValidText(tester, mockDatabaseHelper);
    await deleteHealthEntry(tester, mockDatabaseHelper, 1);
  });

  testWidgets('Add invalid Health Entry test', (WidgetTester tester) async {
    await navigateToHealthEntries(tester, mockDatabaseHelper);
    await healthEntryFillAndSave(tester, mockDatabaseHelper, findsOneWidget);
  });

  testWidgets('Add duplicate Health entry test', (WidgetTester tester) async {
    await navigateToHealthEntries(tester, mockDatabaseHelper);
    await healthEntryFillAndSave(tester, mockDatabaseHelper, findsOneWidget);
    await expectValidText(tester, mockDatabaseHelper);
    when(mockDatabaseHelper.saveHealthEntry(any))
        .thenThrow(Exception("Duplicate entry"));
    await healthEntryFillAndSave(tester, mockDatabaseHelper, findsNWidgets(2));
    await expectErrorText(tester, mockDatabaseHelper);
  });

  testWidgets('Throw error when delete test', (WidgetTester tester) async {
    mockDatabaseHelper = buildMockDatabaseAdapter();
    await navigateToHealthEntries(tester, mockDatabaseHelper);
    await healthEntryFillAndSave(tester, mockDatabaseHelper, findsOneWidget);
    await expectValidText(tester, mockDatabaseHelper);
    await failToDeleteHealthEntry(tester, mockDatabaseHelper, 1);
    await expectErrorText(tester, mockDatabaseHelper);
  });
}

Future navigateToHealthEntries(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseHelper));

  await tester.pump();

  expect(find.text('Gymspector'), findsOneWidget);

  expect(find.byTooltip('Navigation menu'), findsOneWidget);
  await tester.tap(find.byTooltip('Navigation menu'));
  await tester.pumpAndSettle();

  expect(find.byKey(Key('healthRecordsMenuButton')), findsOneWidget);
  await tester.tap(find.byKey(Key('healthRecordsMenuButton')));
  await tester.pumpAndSettle();

  expect(find.text('Health Records'), findsOneWidget);
  expect(find.text('Healthy'), findsNothing);
}

Future healthEntryFillAndSave(WidgetTester tester,
    MockDatabaseHelper mockDatabaseHelper, Matcher matcher) async {
  await tester.showKeyboard(find.byType(TextField));

  tester.testTextInput.updateEditingValue(const TextEditingValue(
    text: 'Healthy',
    selection: TextSelection.collapsed(offset: 1),
  ));

  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();

  expect(find.text('Healthy'), matcher);
  expect(find.byKey(Key('addHealthEntryButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('addHealthEntryButton')));
  await tester.pumpAndSettle();
}

Future expectValidText(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.text('Healthy'), findsOneWidget);
}

Future expectErrorText(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('errorSnack')), findsOneWidget);
}

Future healthEntryEmptySave(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.text('Error'), findsNothing);

  expect(find.byKey(Key('addHealthEntryButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('addHealthEntryButton')));
  await tester.pumpAndSettle();

  expect(find.text("Value Can't Be Empty"), findsOneWidget);
}

Future deleteHealthEntry(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper, int id) async {
  expect(find.byKey(Key('delBtnHealth$id')), findsOneWidget);

  //delete the entry
  await tester.tap(find.byKey(Key('delBtnHealth$id')));
  await tester.pumpAndSettle();

  expect(find.text('Healthy'), findsNothing);
}

Future failToDeleteHealthEntry(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper, int id) async {
  expect(find.byKey(Key('delBtnHealth$id')), findsOneWidget);

  enableThrowOnDeleteHealthEntry(mockDatabaseHelper);

  await tester.tap(find.byKey(Key('delBtnHealth$id')));
  await tester.pumpAndSettle();
}
