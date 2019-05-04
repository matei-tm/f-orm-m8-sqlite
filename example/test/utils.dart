import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _IsToggled extends CustomMatcher {
  _IsToggled(dynamic matcher)
      : super('Check if a SwitchListTile if enabled or not', 'isToggled',
            matcher);

  @override
  Object featureValueOf(dynamic actual) {
    final finder = actual as Finder;
    final result = finder.evaluate().single.widget as SwitchListTile;

    return result.value;
  }
}

Matcher isSwitchListTileToggled(bool value) => _IsToggled(value);
