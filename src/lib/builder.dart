library orm_m8_generator;

import 'package:build/build.dart';
import 'package:flutter_sqlite_m8_generator/generator/database_helper_generator.dart';
import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/m8_builder.dart';

List<EmittedEntity> emittedEntities = List<EmittedEntity>();

Builder m8WrappperBuilder() {
  M8Builder.emittedEntities ??= emittedEntities;
  return M8Builder.withEmitted('.g.m8.dart');
}

Builder m9WrappperBuilder() {
  M8Builder.emittedEntities ??= emittedEntities;
  return M8Builder(DatabaseHelperGenerator(), '.agg.m8.dart');
}

Builder ormM8(BuilderOptions options) => m8WrappperBuilder();
Builder helperM8(BuilderOptions options) => m9WrappperBuilder();
