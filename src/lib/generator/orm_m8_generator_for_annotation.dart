library orm_m8.generator.hook;

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:flutter_orm_m8/flutter_orm_m8.dart';
import 'package:source_gen/source_gen.dart';

class OrmM8GeneratorForAnnotation extends GeneratorForAnnotation<DataTable> {
  const OrmM8GeneratorForAnnotation();

  @override
  Future<String> generateForAnnotatedElement(final Element element,
      ConstantReader annotation, BuildStep buildStep) async {
    try {
      if (element is! ClassElement) {
        throw new Exception(
            "@DataTable annotation must be defined on a class.");
      }

      final String modelName = element.name;
      final String entityName =
          annotation.objectValue.getField('name').toStringValue();
      print("Generating entity for $modelName ... $entityName");

      ModelParser modelParser = new ModelParser(element);
      final EmittedEntity emittedEntity = modelParser.getEmittedEntity();

      final writer = new EntityWriter(emittedEntity);

      return writer.toString();
    } catch (exception, stack) {
      return ExceptionExpander(exception, stack).toString();
    }
  }
}

class ExceptionExpander {
  dynamic exception;

  StackTrace stack;

  ExceptionExpander(this.exception, StackTrace this.stack);

  @override
  String toString() {
    var result = new StringBuffer();
    result.writeln('/*');
    result.write(exception.toString());
    result.writeln();
    result.write(stack);
    result.writeln('*/');

    return result.toString();
  }
}

class EntityWriter {
  EntityWriter(EmittedEntity emittedEntity);
}

class EmittedEntity {}

class ModelParser {
  ModelParser(Element element);

  EmittedEntity getEmittedEntity() {
    return null;
  }
}
