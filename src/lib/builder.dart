library orm_m8_generator;

import 'dart:async';

import 'package:build/build.dart';
import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:source_gen/source_gen.dart';
import 'generator/orm_m8_generator_for_annotation.dart';

Builder m8WrappperBuilder() {
  List<EmittedEntity> emittedEntities = List<EmittedEntity>();
  return M8CustomBuilder(
      OrmM8GeneratorForAnnotation.withEmitted(emittedEntities), '.g.m8.dart');
}

class M8CustomBuilder extends LibraryBuilder {
  List<EmittedEntity> emittedEntities;

  M8CustomBuilder(
      OrmM8GeneratorForAnnotation generator, String generatedExtension)
      : super(generator, generatedExtension: generatedExtension) {
    emittedEntities = generator.emittedEntities;
  }

  @override
  Future build(BuildStep buildStep) async {
    await super.build(buildStep);
    print("=============================>>>>>>>>>>>>> ${emittedEntities.length}");
  }
}

Builder ormM8(BuilderOptions options) => m8WrappperBuilder();
