import 'account_entity_test.dart' as accountEntity;
import 'account_related_composite_entity_test.dart'
    as accountRelatedCompositeEntity;
import 'account_related_entity_test.dart' as accountRelatedEntity;
import 'bad_element_annotation_test.dart' as badElementAnnotation;
import 'flutter_sqlite_m8_generator_test.dart' as flutterSqliteM8Generator;
// import 'independent_entity_test.dart' as independentEntity;
// import 'metadata_level_test.dart' as metadataLevel;
// import 'no_column_metadata_test.dart' as noColumnMetadata;

main() {
  accountEntity.main();
  accountRelatedCompositeEntity.main();
  accountRelatedEntity.main();
  badElementAnnotation.main();
  flutterSqliteM8Generator.main();
  // independentEntity.main();
  // metadataLevel.main();
  // noColumnMetadata.main();
}
