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
  //when(mockDatabaseProvider.extremeDevelopmentMode).thenAnswer((_) => false);
  when(mockDatabaseProvider.getUserAccountProxiesAll())
      .thenAnswer((_) => Future.value(usersList));

  when(mockDatabaseProvider.getHealthEntryProxiesByAccountId(1))
      .thenAnswer((_) => Future.value(List<HealthEntryProxy>()));

  when(mockDatabaseProvider.saveHealthEntry(any))
      .thenAnswer((_) => Future.value(1));

  when(mockDatabaseProvider.deleteHealthEntry(any))
      .thenAnswer((_) => Future.value(1));
}

void enableThrowOnDeleteHealthEntry(MockDatabaseProvider mockDatabaseProvider) {
  when(mockDatabaseProvider.deleteHealthEntry(any))
      .thenThrow(Exception("Invalid database. Could not delete"));
}

void main() {
  MockDatabaseProvider mockDatabaseProvider = buildMockDatabaseAdapter();
  testWidgets('Navigate to health entry test', (WidgetTester tester) async {
    await navigateToHealthEntries(tester, mockDatabaseProvider);
  });

  testWidgets('Add valid Health Entry and delete test',
      (WidgetTester tester) async {
    await navigateToHealthEntries(tester, mockDatabaseProvider);
    await healthEntryFillAndSave(tester, mockDatabaseProvider, findsOneWidget);
    await expectValidText(tester, mockDatabaseProvider);
    await deleteHealthEntry(tester, mockDatabaseProvider, 1);
  });

  testWidgets('Add invalid Health Entry test', (WidgetTester tester) async {
    await navigateToHealthEntries(tester, mockDatabaseProvider);
    await healthEntryFillAndSave(tester, mockDatabaseProvider, findsOneWidget);
  });

  testWidgets('Add duplicate Health entry test', (WidgetTester tester) async {
    await navigateToHealthEntries(tester, mockDatabaseProvider);
    await healthEntryFillAndSave(tester, mockDatabaseProvider, findsOneWidget);
    await expectValidText(tester, mockDatabaseProvider);
    when(mockDatabaseProvider.saveHealthEntry(any))
        .thenThrow(Exception("Duplicate entry"));
    await healthEntryFillAndSave(tester, mockDatabaseProvider, findsNWidgets(2));
    await expectErrorText(tester, mockDatabaseProvider);
  });

  testWidgets('Throw error when delete test', (WidgetTester tester) async {
    mockDatabaseProvider = buildMockDatabaseAdapter();
    await navigateToHealthEntries(tester, mockDatabaseProvider);
    await healthEntryFillAndSave(tester, mockDatabaseProvider, findsOneWidget);
    await expectValidText(tester, mockDatabaseProvider);
    await failToDeleteHealthEntry(tester, mockDatabaseProvider, 1);
    await expectErrorText(tester, mockDatabaseProvider);
  });
}

Future navigateToHealthEntries(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseProvider));

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
    MockDatabaseProvider mockDatabaseProvider, Matcher matcher) async {
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
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  expect(find.text('Healthy'), findsOneWidget);
}

Future expectErrorText(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  expect(find.byKey(Key('errorSnack')), findsOneWidget);
}

Future healthEntryEmptySave(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  expect(find.text('Error'), findsNothing);

  expect(find.byKey(Key('addHealthEntryButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('addHealthEntryButton')));
  await tester.pumpAndSettle();

  expect(find.text("Value Can't Be Empty"), findsOneWidget);
}

Future deleteHealthEntry(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider, int id) async {
  expect(find.byKey(Key('delBtnHealth$id')), findsOneWidget);

  //delete the entry
  await tester.tap(find.byKey(Key('delBtnHealth$id')));
  await tester.pumpAndSettle();

  expect(find.text('Healthy'), findsNothing);
}

Future failToDeleteHealthEntry(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider, int id) async {
  expect(find.byKey(Key('delBtnHealth$id')), findsOneWidget);

  enableThrowOnDeleteHealthEntry(mockDatabaseProvider);

  await tester.tap(find.byKey(Key('delBtnHealth$id')));
  await tester.pumpAndSettle();
}
