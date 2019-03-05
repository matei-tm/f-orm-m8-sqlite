library flutter_sqlite_m8_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:flutter_sqlite_m8_generator/flutter_sqlite_m8_generator.dart';

Builder ormM8(BuilderOptions options) => SharedPartBuilder(
    [EntityHelperM8Generator(), PropertiesHelperM8Generator()],
    'flutter_orm_m8');
