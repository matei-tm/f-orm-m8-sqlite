import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:flutter_orm_m8/flutter_orm_m8.dart';

class EntityHelperM8Generator extends GeneratorForAnnotation<DataTable> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
       String tableName =  annotation.objectValue.getField('name').toStringValue();
       String modelName = element.displayName;
    print(tableName);
    print(modelName);
    return '//Annotation found!' + '$element';
  }
}
