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

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

MockDatabaseHelper buildMockDatabaseAdapter() {
  MockDatabaseHelper mockDatabaseHelper = MockDatabaseHelper();
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

  when(mockDatabaseHelper.getCurrentUserAccount())
      .thenAnswer((_) => Future.value(firstUser));
  when(mockDatabaseHelper.extremeDevelopmentMode).thenAnswer((_) => false);

  List<UserAccountProxy> usersList = List<UserAccountProxy>()..add(firstUser);

  when(mockDatabaseHelper.getCurrentUserAccount())
      .thenAnswer((_) => Future.value(firstUser));
  when(mockDatabaseHelper.extremeDevelopmentMode).thenAnswer((_) => false);
  when(mockDatabaseHelper.getUserAccountProxiesAll())
      .thenAnswer((_) => Future.value(usersList));
  when(mockDatabaseHelper.getUserAccountProxiesCount())
      .thenAnswer((_) => Future.value(1));
  when(mockDatabaseHelper.getHealthEntryProxiesByAccountId(any))
      .thenAnswer((_) => Future.value(List<HealthEntryProxy>()));
}

void main() {
  final MockDatabaseHelper mockDatabaseHelper = buildMockDatabaseAdapter();
  testWidgets('Navigate to account page test', (WidgetTester tester) async {
    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);
  });

  testWidgets('Account page update test', (WidgetTester tester) async {
    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);
    await accountPageFormSubmit(tester, mockDatabaseHelper);
  });

  testWidgets('Account page add new test', (WidgetTester tester) async {
    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);
    await accountPageAddNew(tester, mockDatabaseHelper);
  });

  testWidgets('Account page delete current test', (WidgetTester tester) async {
    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);
    await accountPageDeleteExisting(tester, mockDatabaseHelper);
  });
}

Future navigateToAccountPage(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseHelper));

  await tester.pump();

  expect(find.text('Gymspector'), findsOneWidget);

  expect(find.byTooltip('Navigation menu'), findsOneWidget);
  await tester.tap(find.byTooltip('Navigation menu'));
  await tester.pumpAndSettle();

  expect(find.byKey(Key('userAccountMenuButton')), findsOneWidget);
  await tester.tap(find.byKey(Key('userAccountMenuButton')));
  await tester.pumpAndSettle();
}

Future accountPageEnteredCheck(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byType(TextFormField), findsNWidgets(3));

  expect(find.byKey(Key('accountNameTextFormField')), findsOneWidget);
  expect(find.byKey(Key('saveAccountButton')), findsOneWidget);
  expect(find.text('Edit User account'), findsOneWidget);
}

Future accountPageFormSubmit(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byType(TextFormField), findsNWidgets(3));

  await tester.showKeyboard(find.byKey(Key('accountNameTextFormField')));
  tester.testTextInput.updateEditingValue(const TextEditingValue(
    text: 'John Doe',
    selection: TextSelection.collapsed(offset: 1),
  ));
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();
  expect(find.text('John Doe'), findsOneWidget);

  await tester.showKeyboard(find.byKey(Key('emailTextFormField')));
  tester.testTextInput.updateEditingValue(const TextEditingValue(
    text: 'john@doe.com',
    selection: TextSelection.collapsed(offset: 1),
  ));
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();
  expect(find.text('john@doe.com'), findsOneWidget);

  await tester.showKeyboard(find.byKey(Key('abbreviationTextFormField')));
  tester.testTextInput.updateEditingValue(const TextEditingValue(
    text: 'JD',
    selection: TextSelection.collapsed(offset: 1),
  ));
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();
  expect(find.text('JD'), findsOneWidget);

  expect(find.byKey(Key('saveAccountButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('saveAccountButton')));
}

Future accountPageAddNew(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('addNewAccountButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('addNewAccountButton')));
  await tester.pump();
}

Future accountPageDeleteExisting(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('deleteAccountButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('deleteAccountButton')));
  await tester.pump();
}
