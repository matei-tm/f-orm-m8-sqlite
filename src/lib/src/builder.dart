import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:flutter_sqlite_m8_generator/src/flutter_sqlite_m8_generator.dart';

Builder todoReporter(BuilderOptions options) =>
    SharedPartBuilder([EntityHelperM8Generator()], 'entity_helper');