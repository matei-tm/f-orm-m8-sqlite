import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';

class EntityWriter {
  EmittedEntity emittedEntity;

  EntityWriter(EmittedEntity this.emittedEntity);

  @override
  String toString() {
    StringBuffer sb = StringBuffer();

    sb.writeln('/*');
    sb.writeln(super.toString());
    sb.write(
        'Entity:${emittedEntity.entityName} Model:${emittedEntity.modelName}\n${emittedEntity.attributes.toString()}');
    sb.writeln('*/');

    return sb.toString();
  }
}
