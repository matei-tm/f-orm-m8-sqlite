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

  when(mockDatabaseProvider.getCurrentUserAccount())
      .thenAnswer((_) => Future.value(firstUser));
  //when(mockDatabaseProvider.extremeDevelopmentMode).thenAnswer((_) => false);
}

void main() {
  final MockDatabaseProvider mockDatabaseProvider = buildMockDatabaseAdapter();
  testWidgets('Start page without account test', (WidgetTester tester) async {
    //when(mockDatabaseProvider.extremeDevelopmentMode).thenAnswer((_) => false);
    when(mockDatabaseProvider.getCurrentUserAccount())
        .thenAnswer((_) => Future.value(null));
    await accountPageEntered(tester, mockDatabaseProvider);
  });

  testWidgets('Account page on start test', (WidgetTester tester) async {
    when(mockDatabaseProvider.getCurrentUserAccount())
        .thenAnswer((_) => Future.value(null));
    await accountPageFormSubmit(tester, mockDatabaseProvider);
  });

  testWidgets('Root page with account is Disclaimer test',
      (WidgetTester tester) async {
    enableCurrentUserAccount(mockDatabaseProvider);
    await disclaimerPageEntered(tester, mockDatabaseProvider);
  });
}

Future disclaimerPageEntered(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseProvider));
  await tester.pump();

  expect(find.text('Gymspector'), findsOneWidget);
  expect(find.byTooltip('Navigation menu'), findsOneWidget);
}

Future accountPageEntered(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseProvider));
  await tester.pump();

  expect(find.byType(TextFormField), findsNWidgets(3));

  expect(find.byKey(Key('accountNameTextFormField')), findsOneWidget);
  expect(find.byKey(Key('saveAccountButton')), findsOneWidget);
}

Future accountPageFormSubmit(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseProvider));
  await tester.pump();

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
