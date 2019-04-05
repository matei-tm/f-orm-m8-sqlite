import 'package:build/build.dart';
import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/orm_m8_generator_for_annotation.dart';
import 'package:source_gen/source_gen.dart';

class M8Builder extends LibraryBuilder {
  static List<EmittedEntity> emittedEntities;

  M8Builder(Generator generator, String generatedExtension)
      : super(generator, generatedExtension: generatedExtension) {}

  M8Builder.withEmitted(String generatedExtension)
      : super(OrmM8GeneratorForAnnotation.withEmitted(emittedEntities),
            generatedExtension: generatedExtension) {}

  @override
  Future build(BuildStep buildStep) async {
    await super.build(buildStep);
    print("====> ${emittedEntities.length}");
  }
}
