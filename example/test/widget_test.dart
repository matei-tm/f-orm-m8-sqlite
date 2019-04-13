// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:example/fragments/health_entry_fragment.dart';
import 'package:example/main.adapter.g.m8.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  var _db = DatabaseHelper();
  _db.extremeDevelopmentMode = true;
  testWidgets('Adding health entry smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Health Conditions'), findsOneWidget);
    expect(find.text('Healthy'), findsNothing);

    await tester.showKeyboard(find.byType(TextField));

    tester.testTextInput.updateEditingValue(const TextEditingValue(
      text: 'Healthy',
      selection: TextSelection.collapsed(offset: 1),
    ));

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(find.text('Healthy'), findsOneWidget);
  });
}
