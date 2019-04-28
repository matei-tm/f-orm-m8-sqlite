import 'package:flutter_orm_m8/flutter_orm_m8.dart';

bool isNotNull(int value) {
  return value & ColumnMetadata.notNull == ColumnMetadata.notNull;
}

bool isPrimaryKey(int value) {
  return value & ColumnMetadata.primaryKey == ColumnMetadata.primaryKey;
}

bool isAutoIncrement(int value) {
  return value & ColumnMetadata.autoIncrement == ColumnMetadata.autoIncrement;
}

bool isIndexed(int value) {
  return value & ColumnMetadata.indexed == ColumnMetadata.indexed;
}

bool isUnique(int value) {
  return value & ColumnMetadata.unique == ColumnMetadata.unique;
}

bool mustIgnore(int value) {
  return value & ColumnMetadata.ignore == ColumnMetadata.ignore;
}
