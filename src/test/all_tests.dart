import 'account_entity_test.dart' as accountEntity;
import 'account_related_composite_entity_test.dart'
    as accountRelatedCompositeEntity;
import 'account_related_entity_test.dart' as accountRelatedEntity;
import 'bad_element_annotation_test.dart' as badElementAnnotation;
import 'checkers_test.dart' as checkers;
import 'column_metadata_level_test.dart' as columnMetadataLevel;
import 'exceptions_test.dart' as exceptions;
import 'generic_test.dart' as generic;
import 'independent_entity_test.dart' as independentEntity;
import 'no_column_metadata_test.dart' as noColumnMetadata;
import 'softdelete_test.dart' as softdelete;
import 'validation_test.dart' as validation;

main() {
  accountEntity.main();
  accountRelatedCompositeEntity.main();
  accountRelatedEntity.main();
  badElementAnnotation.main();
  checkers.main();
  columnMetadataLevel.main();
  exceptions.main();
  generic.main();
  independentEntity.main();
  noColumnMetadata.main();
  softdelete.main();
  validation.main();
}
