import 'package:flutter_sqlite_m8_generator/generator/utils/type_utils.dart';

class EntityMetadataParser {
  static String getTableDefinition(int metadataLevel) {
    String definition = "";

    if (isSoftDeletable(metadataLevel)) {
      definition = ", is_deleted INTEGER";
    }

    if (isCreateTrackable(metadataLevel)) {
      definition = ", date_create INTEGER";
    }

    if (isUpdateTrackable(metadataLevel)) {
      definition = ", date_update INTEGER";
    }

    return definition;
  }

  static String getSoftdeleteCondition(int metadataLevel) {
    if (isSoftDeletable(metadataLevel)) {
      return ' AND is_deleted != 1';
    }

    return '';
  }
}
