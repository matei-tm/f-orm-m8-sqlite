library orm_m8_generator.core;

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:flutter_orm_m8/flutter_orm_m8.dart';
import 'package:flutter_sqlite_m8_generator/exceptions/exception_expander.dart';
import 'package:flutter_sqlite_m8_generator/generator/core.dart';
import 'package:source_gen/source_gen.dart';

class OrmM8GeneratorForAnnotation extends GeneratorForAnnotation<DataTable> {
  const OrmM8GeneratorForAnnotation();

  @override
  Future<String> generateForAnnotatedElement(final Element element,
      ConstantReader annotation, BuildStep buildStep) async {
    try {
      if (element is! ClassElement) {
        throw Exception("@DataTable annotation must be defined on a class.");
      }

      final String modelName = element.name;
      final String entityName =
          annotation.objectValue.getField('name').toStringValue();
      print("Generating entity for $modelName ... $entityName");

      ModelParser modelParser = ModelParser(element, entityName);
      final EmittedEntity emittedEntity = modelParser.getEmittedEntity();

      final entityWriter = EntityWriter(emittedEntity);

      return entityWriter.toString();
    } catch (exception, stack) {
      return ExceptionExpander(exception, stack).toString();
    }
  }
}
