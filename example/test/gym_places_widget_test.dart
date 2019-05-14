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
import 'package:sqlite_m8_demo/models/gym_location.g.m8.dart';
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

  when(mockDatabaseProvider.getGymLocationProxiesAll())
      .thenAnswer((_) => Future.value(List<GymLocationProxy>()));

  when(mockDatabaseProvider.saveGymLocation(any))
      .thenAnswer((_) => Future.value(1));

  when(mockDatabaseProvider.deleteGymLocation(any))
      .thenAnswer((_) => Future.value(1));
}

void enableThrowOnDeleteGymLocation(MockDatabaseProvider mockDatabaseProvider) {
  when(mockDatabaseProvider.deleteGymLocation(any))
      .thenThrow(Exception("Invalid database. Could not delete"));
}

void main() {
  MockDatabaseProvider mockDatabaseProvider = buildMockDatabaseAdapter();

  testWidgets('Navigate to Gym Places test', (WidgetTester tester) async {
    await navigateToGymPlaces(tester, mockDatabaseProvider);
  });

  testWidgets('Add valid Gym place and delete test',
      (WidgetTester tester) async {
    await navigateToGymPlaces(tester, mockDatabaseProvider);
    await gymLocationFillAndSave(tester, mockDatabaseProvider, findsOneWidget);
    await expectValidText(tester, mockDatabaseProvider);
    await deleteLocation(tester, mockDatabaseProvider, 1);
  });

  testWidgets('Add invalid Gym place test', (WidgetTester tester) async {
    await navigateToGymPlaces(tester, mockDatabaseProvider);
    await gymLocationEmptySave(tester, mockDatabaseProvider);
  });

  testWidgets('Add duplicate Gym place test', (WidgetTester tester) async {
    await navigateToGymPlaces(tester, mockDatabaseProvider);
    await gymLocationFillAndSave(tester, mockDatabaseProvider, findsOneWidget);
    await expectValidText(tester, mockDatabaseProvider);
    when(mockDatabaseProvider.saveGymLocation(any))
        .thenThrow(Exception("Duplicate entry"));
    await gymLocationFillAndSave(tester, mockDatabaseProvider, findsNWidgets(2));
    await expectErrorText(tester, mockDatabaseProvider);
  });

  testWidgets('Throw error when delete test', (WidgetTester tester) async {
    mockDatabaseProvider = buildMockDatabaseAdapter();
    await navigateToGymPlaces(tester, mockDatabaseProvider);
    await gymLocationFillAndSave(tester, mockDatabaseProvider, findsOneWidget);
    await expectValidText(tester, mockDatabaseProvider);
    await failToDeleteLocation(tester, mockDatabaseProvider, 1);
    await expectErrorText(tester, mockDatabaseProvider);
  });
}

Future navigateToGymPlaces(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseProvider));

  await tester.pump();

  expect(find.text('Gymspector'), findsOneWidget);

  expect(find.byTooltip('Navigation menu'), findsOneWidget);
  await tester.tap(find.byTooltip('Navigation menu'));
  await tester.pumpAndSettle();

  expect(find.byKey(Key('gymPlacesMenuButton')), findsOneWidget);
  await tester.tap(find.byKey(Key('gymPlacesMenuButton')));
  await tester.pumpAndSettle();

  expect(find.text('Gym Places'), findsOneWidget);
  expect(find.text('Silva'), findsNothing);
}

Future gymLocationFillAndSave(WidgetTester tester,
    MockDatabaseProvider mockDatabaseProvider, Matcher matcher) async {
  await tester.showKeyboard(find.byType(TextField));

  tester.testTextInput.updateEditingValue(const TextEditingValue(
    text: 'Silva',
    selection: TextSelection.collapsed(offset: 1),
  ));

  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();

  expect(find.text('Silva'), matcher);
  expect(find.byKey(Key('addGymPlaceButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('addGymPlaceButton')));
  await tester.pumpAndSettle();
}

Future expectValidText(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  expect(find.text('Silva'), findsOneWidget);
}

Future expectErrorText(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  expect(find.byKey(Key('errorSnack')), findsOneWidget);
}

Future gymLocationEmptySave(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider) async {
  expect(find.text("Value Can't Be Empty"), findsNothing);

  expect(find.byKey(Key('addGymPlaceButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('addGymPlaceButton')));
  await tester.pumpAndSettle();

  expect(find.text("Value Can't Be Empty"), findsOneWidget);
}

Future deleteLocation(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider, int id) async {
  expect(find.byKey(Key('delBtnGymPlace$id')), findsOneWidget);

  //delete the entry
  await tester.tap(find.byKey(Key('delBtnGymPlace$id')));
  await tester.pumpAndSettle();

  expect(find.text('Silva'), findsNothing);
}

Future failToDeleteLocation(
    WidgetTester tester, MockDatabaseProvider mockDatabaseProvider, int id) async {
  expect(find.byKey(Key('delBtnGymPlace$id')), findsOneWidget);

  enableThrowOnDeleteGymLocation(mockDatabaseProvider);

  await tester.tap(find.byKey(Key('delBtnGymPlace$id')));
  await tester.pumpAndSettle();
}
