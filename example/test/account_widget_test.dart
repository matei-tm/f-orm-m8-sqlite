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
import 'package:sqlite_m8_demo/models/health_entry.dart';
import 'package:sqlite_m8_demo/models/health_entry.g.m8.dart';
import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

MockDatabaseHelper buildMockDatabaseAdapter() {
  MockDatabaseHelper mockDatabaseHelper = MockDatabaseHelper();
  enableCurrentUserAccount(mockDatabaseHelper);

  return mockDatabaseHelper;
}

UserAccountProxy firstUser;
UserAccountProxy secondUser;

void enableCurrentUserAccount(MockDatabaseHelper mockDatabaseHelper) {
  firstUser = getFirstUser();

  List<UserAccountProxy> usersList = List<UserAccountProxy>()..add(firstUser);

  when(mockDatabaseHelper.getCurrentUserAccount())
      .thenAnswer((_) => Future.value(firstUser));
  when(mockDatabaseHelper.getUserAccountProxiesAll())
      .thenAnswer((_) => Future.value(usersList));
  when(mockDatabaseHelper.getUserAccountProxiesCount())
      .thenAnswer((_) => Future.value(1));
  when(mockDatabaseHelper.getHealthEntryProxiesByAccountId(any))
      .thenAnswer((_) => Future.value(List<HealthEntryProxy>()));
}

UserAccountProxy getFirstUser() {
  var user = UserAccountProxy();
  user.id = 1;
  user.email = "John@Doe.com";
  user.abbreviation = "JD";
  user.description = "Tester John";
  user.userName = "John Doe";
  user.isCurrent = true;

  return user;
}

UserAccountProxy getSecondUser() {
  var user = UserAccountProxy();
  user = UserAccountProxy();
  user.id = 2;
  user.email = "John@Nash.com";
  user.abbreviation = "JN";
  user.description = "Tester Nash";
  user.userName = "John Nash";
  user.isCurrent = false;

  return user;
}

void enableSecondUserAccount(MockDatabaseHelper mockDatabaseHelper) {
  secondUser = getSecondUser();

  List<UserAccountProxy> usersList = List<UserAccountProxy>()..add(secondUser);

  when(mockDatabaseHelper.getCurrentUserAccount())
      .thenAnswer((_) => Future.value(secondUser));
  when(mockDatabaseHelper.getUserAccountProxiesAll())
      .thenAnswer((_) => Future.value(usersList));
  when(mockDatabaseHelper.getUserAccountProxiesCount())
      .thenAnswer((_) => Future.value(1));
  when(mockDatabaseHelper.getHealthEntryProxiesByAccountId(any))
      .thenAnswer((_) => Future.value(List<HealthEntryProxy>()));
}

void enableNoUserAccount(MockDatabaseHelper mockDatabaseHelper) {
  secondUser = getSecondUser();

  List<UserAccountProxy> usersList = List<UserAccountProxy>();

  when(mockDatabaseHelper.getCurrentUserAccount())
      .thenAnswer((_) => Future.value(null));
  when(mockDatabaseHelper.getUserAccountProxiesAll())
      .thenAnswer((_) => Future.value(usersList));
  when(mockDatabaseHelper.getUserAccountProxiesCount())
      .thenAnswer((_) => Future.value(0));
  when(mockDatabaseHelper.getHealthEntryProxiesByAccountId(any))
      .thenAnswer((_) => Future.value(List<HealthEntryProxy>()));
}

void main() {
  final MockDatabaseHelper mockDatabaseHelper = buildMockDatabaseAdapter();
  testWidgets('Navigate to account page test', (WidgetTester tester) async {
    enableCurrentUserAccount(mockDatabaseHelper);
    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);
  });

  testWidgets('Account page update test', (WidgetTester tester) async {
    enableCurrentUserAccount(mockDatabaseHelper);
    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);
    await accountPageFormSubmit(tester, mockDatabaseHelper);
  });

  testWidgets('Account page add new test', (WidgetTester tester) async {
    enableCurrentUserAccount(mockDatabaseHelper);
    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);

    await accountPageAddNew(tester, mockDatabaseHelper);
    await accountPageCancelAddNew(tester, mockDatabaseHelper);

    await accountPageAddNew(tester, mockDatabaseHelper);
    await accountPageConfirmAddNew(tester, mockDatabaseHelper);
  });

  testWidgets('Account page add new over limit test',
      (WidgetTester tester) async {
    enableCurrentUserAccount(mockDatabaseHelper);
    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);

    when(mockDatabaseHelper.getUserAccountProxiesCount())
        .thenAnswer((_) => Future.value(4));

    await accountPageAddNew(tester, mockDatabaseHelper);
    await accountPageAcceptLimitReached(tester, mockDatabaseHelper);
  });

  testWidgets('Account page delete current test', (WidgetTester tester) async {
    enableCurrentUserAccount(mockDatabaseHelper);
    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);

    await accountPageDeleteExisting(tester, mockDatabaseHelper);
    await accountPageCancelDelete(tester, mockDatabaseHelper);

    await accountPageDeleteExisting(tester, mockDatabaseHelper);
    await accountPageConfirmDelete(tester, mockDatabaseHelper);
  });

  testWidgets('Account page try delete current with dependents test',
      (WidgetTester tester) async {
    enableCurrentUserAccount(mockDatabaseHelper);
    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);

    when(mockDatabaseHelper.getHealthEntryProxiesByAccountId(any)).thenAnswer(
        (_) => Future.value(List<HealthEntry>()..add(HealthEntry()..id = 1)));

    await accountPageDeleteExisting(tester, mockDatabaseHelper);

    await accountPageAcceptHasDependents(tester, mockDatabaseHelper);
  });

  testWidgets('Account page delete last user test',
      (WidgetTester tester) async {
    enableCurrentUserAccount(mockDatabaseHelper);

    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);

    await accountPageDeleteExisting(tester, mockDatabaseHelper);
    await accountPageConfirmDelete(tester, mockDatabaseHelper);

    when(mockDatabaseHelper.deleteUserAccount(1))
        .thenAnswer((_) => Future.value(1));
    when(mockDatabaseHelper.getUserAccountProxiesAll())
        .thenAnswer((_) => Future.value(List<UserAccountProxy>()));
  });

  testWidgets('Account page delete non-last user test',
      (WidgetTester tester) async {
    enableCurrentUserAccount(mockDatabaseHelper);

    await navigateToAccountPage(tester, mockDatabaseHelper);
    await accountPageEnteredCheck(tester, mockDatabaseHelper);

    await accountPageDeleteExisting(tester, mockDatabaseHelper);

    when(mockDatabaseHelper.deleteUserAccount(1))
        .thenAnswer((_) => Future.value(1));
    enableSecondUserAccount(mockDatabaseHelper);

    await accountPageConfirmDelete(tester, mockDatabaseHelper);
    expect(find.text('Gymspector'), findsOneWidget);
  });

  testWidgets('Account page delete unsaved user with reset test',
      (WidgetTester tester) async {
    enableNoUserAccount(mockDatabaseHelper);

    await startPageEntered(tester, mockDatabaseHelper);

    await accountPageDeleteExisting(tester, mockDatabaseHelper);

    await accountPageAcceptReset(tester, mockDatabaseHelper);
  });

  testWidgets('Account page try delete unsaved user with reject reset test',
      (WidgetTester tester) async {
    enableNoUserAccount(mockDatabaseHelper);

    await startPageEntered(tester, mockDatabaseHelper);

    await accountPageDeleteExisting(tester, mockDatabaseHelper);

    await accountPageCancelReset(tester, mockDatabaseHelper);
  });
}

Future startPageEntered(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseHelper));
  await tester.pump();
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
  await tester.pumpAndSettle();
}

Future accountPageCancelAddNew(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('cancelAddingAccount')), findsOneWidget);
  await tester.tap(find.byKey(Key('cancelAddingAccount')));
  await tester.pumpAndSettle();
}

Future accountPageConfirmAddNew(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('confirmAddingAccount')), findsOneWidget);
  await tester.tap(find.byKey(Key('confirmAddingAccount')));
  await tester.pumpAndSettle();
}

Future accountPageDeleteExisting(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('deleteAccountButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('deleteAccountButton')));
  await tester.pumpAndSettle();
}

Future accountPageCancelDelete(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('cancelDeleteAccount')), findsOneWidget);
  await tester.tap(find.byKey(Key('cancelDeleteAccount')));
  await tester.pumpAndSettle();
}

Future accountPageConfirmDelete(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('confirmDeleteAccount')), findsOneWidget);
  await tester.tap(find.byKey(Key('confirmDeleteAccount')));
  await tester.pumpAndSettle();
}

Future accountPageAcceptReset(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('acceptResetAccount')), findsOneWidget);
  await tester.tap(find.byKey(Key('acceptResetAccount')));
  await tester.pumpAndSettle();
}

Future accountPageCancelReset(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('cancelResetAccount')), findsOneWidget);
  await tester.tap(find.byKey(Key('cancelResetAccount')));
  await tester.pumpAndSettle();
}

Future accountPageAcceptLimitReached(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('okLimitReached')), findsOneWidget);
  await tester.tap(find.byKey(Key('okLimitReached')));
  await tester.pumpAndSettle();
}

Future accountPageAcceptHasDependents(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('acceptHasDependents')), findsOneWidget);
  await tester.tap(find.byKey(Key('acceptHasDependents')));
  await tester.pumpAndSettle();
}
