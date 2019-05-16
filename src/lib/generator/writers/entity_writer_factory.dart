import 'package:f_orm_m8_sqlite/generator/core.dart';
import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';
import 'package:f_orm_m8_sqlite/generator/writers/account_entity_writer.dart';
import 'package:f_orm_m8_sqlite/generator/writers/account_related_entity_writer.dart';
import 'package:f_orm_m8_sqlite/generator/writers/independent_entity_writer.dart';
import 'package:f_orm_m8_sqlite/generator/writers/open_entity_writer.dart';

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
      case EntityType.open:
        return OpenEntityWriter(emittedEntity);
        break;
      default:
        return EntityWriter(emittedEntity);
    }
  }
}
