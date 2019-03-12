import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

Future<LibraryReader> resolveCompilationUnit(
    String sourceDirectory, String package) async {
  final files =
      Directory(sourceDirectory).listSync().whereType<File>().toList();

  files.sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

  final fileMap =
      Map<String, String>.fromEntries(files.map((f) => mapEntry(f, package)));

  final library = await resolveSources(fileMap, (item) async {
    final assetId = AssetId.parse(fileMap.keys.first);
    return await item.libraryFor(assetId);
  });

  return LibraryReader(library);
}

MapEntry<String, String> mapEntry(File f, String package) {
  var a =
      MapEntry('${package}|lib/${p.basename(f.path)}', f.readAsStringSync());
  return a;
}
