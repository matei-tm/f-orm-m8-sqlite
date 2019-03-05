import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:flutter_orm_m8/flutter_orm_m8.dart';

class PropertiesHelperM8Generator extends GeneratorForAnnotation<DataColumn> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
       String columnName =  annotation.objectValue.getField('name').toStringValue();
       String modelName = element.displayName;
    print(columnName);
    print(modelName);
    return '//Annotation found!' + '$columnName';
  }
}
