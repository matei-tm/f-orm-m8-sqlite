import 'dart:mirrors';
import 'package:f_orm_m8_sqlite/orm_m8_generator.dart';
import 'package:path/path.dart' as p;
import 'dart:io' show File, Platform;

import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

String testFilePath(String part1, [String part2, String part3]) =>
    p.join(_packagePath(), part1, part2, part3);

String _packagePathCache;

String _packagePath() {
  if (_packagePathCache == null) {
    final currentFilePath = (reflect(_packagePath) as ClosureMirror)
        .function
        .location
        .sourceUri
        .normalizePath()
        .toFilePath(windows: Platform.isWindows);

    _packagePathCache =
        p.normalize(p.join(p.join(p.dirname(currentFilePath), '..'), '..'));
  }
  return _packagePathCache;
}

Future matchProbeOnCaliber(OrmM8GeneratorForAnnotation generator,
    LibraryReader library, String caliberPath) async {
  String output = await generator.generate(library, null);

  final expected = await File(caliberPath).readAsString();
  expect(output, expected);
}
