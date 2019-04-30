// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:example/main.adapter.g.m8.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  var _db = DatabaseHelper();
  _db.extremeDevelopmentMode = true;

  testWidgets('Start page smoke test', (WidgetTester tester) async {
    await accountPageFormSubmit(tester);
    //await healthEntrySubmit(tester);
  });
}

Future healthEntrySubmit(WidgetTester tester) async {
  await tester.pumpWidget(GymspectorApp());

  expect(find.text('Health Records'), findsOneWidget);
  expect(find.text('Healthy'), findsNothing);

  await tester.showKeyboard(find.byType(TextField));

  tester.testTextInput.updateEditingValue(const TextEditingValue(
    text: 'Healthy',
    selection: TextSelection.collapsed(offset: 1),
  ));

  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();

  expect(find.text('Healthy'), findsOneWidget);
  expect(find.byKey(Key('addHealthEntryButton')), findsOneWidget);

  await tester.tap(find.byKey(Key('addHealthEntryButton')));
}

Future accountPageFormSubmit(WidgetTester tester) async {
  await tester.pumpWidget(GymspectorApp(), Duration(seconds: 3));
  await tester.pump(Duration(seconds: 3));

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
