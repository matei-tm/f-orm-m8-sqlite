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
  testWidgets('Navigate to Receipts entry test', (WidgetTester tester) async {
    mockDatabaseHelper.extremeDevelopmentMode = false;
    enableCurrentUserAccount(mockDatabaseHelper);

    await gymLocationSubmit(tester, mockDatabaseHelper);
  });
}

Future gymLocationSubmit(
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

  expect(find.byKey(Key('addReceiptButton')), findsOneWidget);
  await tester.tap(find.byKey(Key('addReceiptButton')));
  await tester.pumpAndSettle();

  expect(find.text('Add Receipt'), findsOneWidget);
}
