library orm_m8_generator;

import 'package:build/build.dart';
import 'package:flutter_sqlite_m8_generator/m8_builder.dart';

Builder ormBuilder() {
  return M8Builder.withWrapper(
      generatedAdapterExtension: '.adapter.g.m8.dart',
      helpersExtension: '.g.m8.dart');
}

Builder ormM8(BuilderOptions options) => ormBuilder();
