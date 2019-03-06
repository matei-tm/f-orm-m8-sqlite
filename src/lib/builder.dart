library flutter_sqlite_m8_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:flutter_sqlite_m8_generator/flutter_sqlite_m8_generator.dart';

Builder ormM8PartBuilder({String header}) =>
    PartBuilder([EntityHelperM8Generator()], '.m8.dart', header: header);

Builder ormM8(BuilderOptions options) =>
    ormM8PartBuilder(header: options.config['header'] as String);
