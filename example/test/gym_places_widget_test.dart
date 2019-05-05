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

  when(mockDatabaseHelper.getGymLocationProxiesAll())
      .thenAnswer((_) => Future.value(List<GymLocationProxy>()));

  when(mockDatabaseHelper.saveGymLocation(any))
      .thenAnswer((_) => Future.value(1));

  when(mockDatabaseHelper.deleteGymLocation(any))
      .thenAnswer((_) => Future.value(1));
}

void enableThrowOnDeleteGymLocation(MockDatabaseHelper mockDatabaseHelper) {
  when(mockDatabaseHelper.deleteGymLocation(any))
      .thenThrow(Exception("Invalid database. Could not delete"));
}

void main() {
  MockDatabaseHelper mockDatabaseHelper = buildMockDatabaseAdapter();

  testWidgets('Navigate to Gym Places test', (WidgetTester tester) async {
    await navigateToGymPlaces(tester, mockDatabaseHelper);
  });

  testWidgets('Add valid Gym place and delete test',
      (WidgetTester tester) async {
    await navigateToGymPlaces(tester, mockDatabaseHelper);
    await gymLocationFillAndSave(tester, mockDatabaseHelper, findsOneWidget);
    await expectValidText(tester, mockDatabaseHelper);
    await deleteLocation(tester, mockDatabaseHelper, 1);
  });

  testWidgets('Add invalid Gym place test', (WidgetTester tester) async {
    await navigateToGymPlaces(tester, mockDatabaseHelper);
    await gymLocationEmptySave(tester, mockDatabaseHelper);
  });

  testWidgets('Add duplicate Gym place test', (WidgetTester tester) async {
    await navigateToGymPlaces(tester, mockDatabaseHelper);
    await gymLocationFillAndSave(tester, mockDatabaseHelper, findsOneWidget);
    await expectValidText(tester, mockDatabaseHelper);
    when(mockDatabaseHelper.saveGymLocation(any))
        .thenThrow(Exception("Duplicate entry"));
    await gymLocationFillAndSave(tester, mockDatabaseHelper, findsNWidgets(2));
    await expectErrorText(tester, mockDatabaseHelper);
  });

  testWidgets('Throw error when delete test', (WidgetTester tester) async {
    mockDatabaseHelper = buildMockDatabaseAdapter();
    await navigateToGymPlaces(tester, mockDatabaseHelper);
    await gymLocationFillAndSave(tester, mockDatabaseHelper, findsOneWidget);
    await expectValidText(tester, mockDatabaseHelper);
    await failToDeleteLocation(tester, mockDatabaseHelper, 1);
    await expectErrorText(tester, mockDatabaseHelper);
  });
}

Future navigateToGymPlaces(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  await tester.pumpWidget(GymspectorApp(mockDatabaseHelper));

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
    MockDatabaseHelper mockDatabaseHelper, Matcher matcher) async {
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
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.text('Silva'), findsOneWidget);
}

Future expectErrorText(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.byKey(Key('errorSnack')), findsOneWidget);
}

Future gymLocationEmptySave(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper) async {
  expect(find.text("Value Can't Be Empty"), findsNothing);

  expect(find.byKey(Key('addGymPlaceButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('addGymPlaceButton')));
  await tester.pumpAndSettle();

  expect(find.text("Value Can't Be Empty"), findsOneWidget);
}

Future deleteLocation(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper, int id) async {
  expect(find.byKey(Key('delBtnGymPlace$id')), findsOneWidget);

  //delete the entry
  await tester.tap(find.byKey(Key('delBtnGymPlace$id')));
  await tester.pumpAndSettle();

  expect(find.text('Silva'), findsNothing);
}

Future failToDeleteLocation(
    WidgetTester tester, MockDatabaseHelper mockDatabaseHelper, int id) async {
  expect(find.byKey(Key('delBtnGymPlace$id')), findsOneWidget);

  enableThrowOnDeleteGymLocation(mockDatabaseHelper);

  await tester.tap(find.byKey(Key('delBtnGymPlace$id')));
  await tester.pumpAndSettle();
}
