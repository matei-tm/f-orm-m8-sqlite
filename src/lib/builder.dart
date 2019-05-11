library orm_m8_generator;

import 'package:build/build.dart';
import 'package:f_orm_m8_sqlite/m8_builder.dart';

Builder ormBuilder() {
  return M8Builder.withWrapper(
      generatedAdapterExtension: '.adapter.g.m8.dart',
      helpersExtension: '.g.m8.dart',
      databaseFileStamp: '0.2.0',
      header:
          "// GENERATED CODE - DO NOT MODIFY BY HAND\n// Emitted on: ${DateTime.now()}");
}

Builder ormM8(BuilderOptions options) => ormBuilder();
