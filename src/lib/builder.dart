library orm_m8_generator;

import 'package:build/build.dart';
import 'package:flutter_sqlite_m8_generator/m8_builder.dart';

Builder ormBuilder() {
  return M8Builder.withWrapper(
      generatedAdapterExtension: '.adapter.g.m8.dart',
      helpersExtension: '.g.m8.dart',
      databaseFileStamp: '0.1.0');
}

Builder ormM8(BuilderOptions options) => ormBuilder();
