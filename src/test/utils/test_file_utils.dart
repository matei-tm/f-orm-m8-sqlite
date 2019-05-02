import 'dart:mirrors';
import 'package:path/path.dart' as p;
import 'dart:io' show Platform;

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
