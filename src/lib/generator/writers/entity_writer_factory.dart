import 'package:flutter_sqlite_m8_generator/generator/core.dart';
import 'package:flutter_sqlite_m8_generator/generator/utils/utils.dart';
import 'package:flutter_sqlite_m8_generator/generator/writers/account_entity_writer.dart';
import 'package:flutter_sqlite_m8_generator/generator/writers/account_related_entity_writer.dart';
import 'package:flutter_sqlite_m8_generator/generator/writers/independent_entity_writer.dart';

class EntityWriterFactory {
  EntityWriter getWriter(EmittedEntity emittedEntity) {
    switch (emittedEntity.entityType) {
      case EntityType.accountRelated:
        return AccountRelatedEntityWriter(emittedEntity);
        break;
      case EntityType.account:
        return AccountEntityWriter(emittedEntity);
        break;
      case EntityType.independent:
        return IndependentEntityWriter(emittedEntity);
        break;
      default:
        return EntityWriter(emittedEntity);
    }
  }
}
