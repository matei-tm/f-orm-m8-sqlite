import 'package:flutter_sqlite_m8_generator/generator/utils/type_utils.dart';

class EntityMetadataParser {
  static String getSoftdeleteCondition(int metadataLevel) {
    if (isSoftDeletable(metadataLevel)) {
      return ' AND is_deleted != 1';
    }

    return '';
  }
}
