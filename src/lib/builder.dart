library orm_m8_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'generator/orm_m8_generator_for_annotation.dart';

Builder m8GeneratorBuilder() =>
    PartBuilder([OrmM8GeneratorForAnnotation()], '.m8.dart');

Builder ormM8(BuilderOptions options) =>
    m8GeneratorBuilder();
