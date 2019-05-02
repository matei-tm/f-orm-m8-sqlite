import 'account_entity_test.dart' as accountEntity;
import 'account_related_composite_entity_test.dart'
    as accountRelatedCompositeEntity;
import 'account_related_entity_test.dart' as accountRelatedEntity;
import 'bad_element_annotation_test.dart' as badElementAnnotation;
import 'generic_test.dart' as generic;
import 'independent_entity_test.dart' as independentEntity;
import 'column_metadata_level_test.dart' as columnMetadataLevel;
import 'no_column_metadata_test.dart' as noColumnMetadata;

main() {
  accountEntity.main();
  accountRelatedCompositeEntity.main();
  accountRelatedEntity.main();
  badElementAnnotation.main();
  generic.main();
  independentEntity.main();
  columnMetadataLevel.main();
  noColumnMetadata.main();
}
