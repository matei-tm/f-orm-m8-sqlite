library orm_m8_generator.wrapper;

import 'dart:async';

import 'package:build/build.dart';
import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/writers/database_helper_writer.dart';
import 'package:source_gen/source_gen.dart';

class DatabaseHelperGenerator extends Generator {
  List<EmittedEntity> emittedEntities;

  final String databaseFileStamp;
  final String helpersExtension;

  DatabaseHelperGenerator(this.databaseFileStamp, this.helpersExtension);

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    var name = library.element.name;
    if (name.isEmpty) {
      name = library.element.source.uri.pathSegments.last;
    }

    //if not main.dart then generate nothing
    if (name != 'main.dart') return '';

    //sort emittedEntities by modelName
    emittedEntities.sort((l, r) => l.modelName.compareTo(r.modelName));
    return DatabaseHelperWriter(
            emittedEntities, databaseFileStamp, helpersExtension)
        .toString();
  }
}
