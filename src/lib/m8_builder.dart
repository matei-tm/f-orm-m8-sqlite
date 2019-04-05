import 'package:build/build.dart';
import 'package:flutter_sqlite_m8_generator/generator/database_helper_generator.dart';
import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/orm_m8_generator_for_annotation.dart';
import 'package:source_gen/source_gen.dart';

class M8Builder extends LibraryBuilder {
  static List<EmittedEntity> emittedEntities;
  static DatabaseHelperGenerator databaseHelperGenerator;

  LibraryBuilder annotationBuilder;
  OrmM8GeneratorForAnnotation ormM8GeneratorForAnnotation;

  String generatedAdapterExtension;
  String helpersExtension;
  String databaseFileStamp;

  M8Builder.withWrapper(
      {String generatedAdapterExtension = '.adapter.g.m8.dart',
      String helpersExtension = '.g.m8.dart',
      String databaseFileStamp = '0.1.1'})
      : super(
            databaseHelperGenerator ??=
                DatabaseHelperGenerator(databaseFileStamp, helpersExtension),
            generatedExtension: generatedAdapterExtension,
            additionalOutputExtensions: [helpersExtension]) {
    this.generatedAdapterExtension = generatedAdapterExtension;
    this.helpersExtension = helpersExtension;
    this.databaseFileStamp = databaseFileStamp;
    emittedEntities = List<EmittedEntity>();
    annotationBuilder = LibraryBuilder(
        OrmM8GeneratorForAnnotation.withEmitted(emittedEntities),
        generatedExtension: helpersExtension);
  }
  @override
  Future build(BuildStep buildStep) async {
    await annotationBuilder.build(buildStep);

    //nothing to be emmitted regarding to entities, after annotationBuilder finished build
    databaseHelperGenerator.emittedEntities ??= emittedEntities;

    return super.build(buildStep);
  }
}
