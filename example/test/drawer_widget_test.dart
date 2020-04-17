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

class MockDatabaseProvider extends Mock implements DatabaseProvider {}

MockDatabaseProvider buildMockDatabaseAdapter() {
  MockDatabaseProvider mockDatabaseProvider = MockDatabaseProvider();

  enableCurrentUserAccount(mockDatabaseProvider);

  return mockDatabaseProvider;
}

UserAccountProxy firstUser;
UserAccountProxy secondUser;

void enableCurrentUserAccount(MockDatabaseProvider mockDatabaseProvider) {
  firstUser = UserAccountProxy();
  firstUser.id = 1;
  firstUser.email = "John@Doe.com";
  firstUser.abbreviation = "JD";
  firstUser.description = "Tester John";
  firstUser.userName = "John Doe";
  firstUser.isCurrent = true;

  secondUser = UserAccountProxy();
  secondUser.id = 2;
  secondUser.email = "John@Nash.com";
  secondUser.abbreviation = "JN";
  secondUser.description = "Tester Nash";
  secondUser.userName = "John Nash";
  secondUser.isCurrent = false;

  List<UserAccountProxy> usersList = List<UserAccountProxy>()
    ..add(firstUser)
    ..add(secondUser);

  when(mockDatabaseProvider.getCurrentUserAccount())
      .thenAnswer((_) => Future.value(firstUser));

  when(mockDatabaseProvider.getUserAccountProxiesAll())
      .thenAnswer((_) => Future.value(usersList));
  when(mockDatabaseProvider.getUserAccountProxiesCount())
      .thenAnswer((_) => Future.value(2));
  when(mockDatabaseProvider.setCurrentUserAccount(any)).thenAnswer((_) {
    firstUser.isCurrent = false;
    secondUser.isCurrent = true;
    return Future.value(2);
  });
}

void main() {
  final MockDatabaseProvider mockDatabaseProvider = buildMockDatabaseAdapter();
  testWidgets('Navigate to drawer entry test', (WidgetTester tester) async {
    await drawerOpenedWithAccounts(tester, mockDatabaseProvider);
  });

  testWidgets('Switch account test', (WidgetTester tester) async {
    await drawerOpenedWithAccounts(tester, mockDatabaseProvider);
    await drawerCancelSwitchAccount(tester, mockDatabaseProvider, 2);
    await drawerConfirmSwitchAccount(tester, mockDatabaseProvider, 2);
  });
}

Future drawerOpenedWithAccounts(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseProvider));

  await tester.pump();

  expect(find.text('Gymspector'), findsOneWidget);

  expect(find.byTooltip('Navigation menu'), findsOneWidget);
  await tester.tap(find.byTooltip('Navigation menu'));
  await tester.pumpAndSettle();

  //look for current account
  expect(find.text('JD'), findsOneWidget);
  expect(find.text('John Doe'), findsOneWidget);
  expect(find.text('John@Doe.com'), findsOneWidget);

  //look for other account
  expect(find.text('JN'), findsOneWidget);
}

Future drawerCancelSwitchAccount(WidgetTester tester,
    MockDatabaseProvider mockDatabaseProvider, int id) async {
  expect(find.byKey(Key('accountAvatar$id')), findsOneWidget);
  await tester.tap(find.byKey(Key('accountAvatar$id')));
  await tester.pumpAndSettle();

  expect(find.byKey(Key('cancelSwitchingAccount')), findsOneWidget);
  await tester.tap(find.byKey(Key('cancelSwitchingAccount')));

  await tester.pumpAndSettle();
}

Future drawerConfirmSwitchAccount(WidgetTester tester,
    MockDatabaseProvider mockDatabaseProvider, int id) async {
  expect(find.byKey(Key('accountAvatar$id')), findsOneWidget);
  await tester.tap(find.byKey(Key('accountAvatar$id')));
  await tester.pumpAndSettle();

  expect(find.byKey(Key('confirmSwitchingAccount')), findsOneWidget);
  await tester.tap(find.byKey(Key('confirmSwitchingAccount')));

  await tester.pumpAndSettle();
}
