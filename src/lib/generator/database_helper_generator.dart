library orm_m8_generator.wrapper;

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class DatabaseHelperGenerator extends Generator {
  final bool forClasses, forLibrary;

  const DatabaseHelperGenerator(
      {this.forClasses = true, this.forLibrary = true});

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final output = <String>[];
    if (forLibrary) {
      var name = library.element.name;
      if (name.isEmpty) {
        name = library.element.source.uri.pathSegments.last;
      }
      output.add('// Code for "$name"');
    }
    if (forClasses) {
      for (var classElement
          in library.allElements.where((e) => e is ClassElement)) {
        if (classElement.displayName.contains('GoodError')) {
          throw InvalidGenerationSourceError(
              "Don't use classes with the word 'Error' in the name",
              todo: 'Rename ${classElement.displayName} to something else.',
              element: classElement);
        }
        output.add('// Code for "$classElement"');
      }
    }
    return output.join('\n');
  }
}
