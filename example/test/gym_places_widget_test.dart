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

  when(mockDatabaseHelper.getGymLocationProxiesAll())
      .thenAnswer((_) => Future.value(null));

  when(mockDatabaseHelper.saveGymLocation(any))
      .thenAnswer((_) => Future.value(1));

  when(mockDatabaseHelper.deleteGymLocation(any))
      .thenAnswer((_) => Future.value(1));
}

void main() {
  final MockDatabaseHelper mockDatabaseHelper = buildMockDatabaseAdapter();
  testWidgets('Navigate to Gym Places entry test', (WidgetTester tester) async {
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

  expect(find.byKey(Key('gymPlacesMenuButton')), findsOneWidget);
  await tester.tap(find.byKey(Key('gymPlacesMenuButton')));
  await tester.pumpAndSettle();

  expect(find.text('Gym Places'), findsOneWidget);
  expect(find.text('Silva'), findsNothing);

  await tester.showKeyboard(find.byType(TextField));

  tester.testTextInput.updateEditingValue(const TextEditingValue(
    text: 'Silva',
    selection: TextSelection.collapsed(offset: 1),
  ));

  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();

  expect(find.text('Silva'), findsOneWidget);
  expect(find.byKey(Key('addGymPlaceButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('addGymPlaceButton')));
  await tester.pumpAndSettle();

  expect(find.text('Silva'), findsOneWidget);
  expect(find.byKey(Key('delBtnGymPlace1')), findsOneWidget);

  //delete the entry
  await tester.tap(find.byKey(Key('delBtnGymPlace1')));
  await tester.pumpAndSettle();

  expect(find.text('Silva'), findsNothing);
}
