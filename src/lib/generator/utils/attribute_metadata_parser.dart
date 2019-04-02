import 'package:flutter_sqlite_m8_generator/generator/utils/type_utils.dart';

class AttributeMetadataParser {
  static String getDefinition(int metadataLevel) {
    String definition = "";

    if (isNotNull(metadataLevel)) {
      definition = "$definition NOT NULL";
    }

    if (isPrimaryKey(metadataLevel)) {
      definition = "$definition PRIMARY KEY";
    }

    if (isAutoIncrement(metadataLevel)) {
      definition = "$definition AUTOINCREMENT";
    }

    if (isUnique(metadataLevel)) {
      definition = "$definition UNIQUE";
    }

    return definition;
  }
}
