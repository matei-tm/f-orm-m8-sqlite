import 'package:flutter_orm_m8/flutter_orm_m8.dart';

bool isNotNull(int value) {
  return value & ColumnMetadata.NotNull == ColumnMetadata.NotNull;
}

bool isPrimaryKey(int value) {
  return value & ColumnMetadata.PrimaryKey == ColumnMetadata.PrimaryKey;
}

bool isAutoIncrement(int value) {
  return value & ColumnMetadata.AutoIncrement == ColumnMetadata.AutoIncrement;
}

bool isIndexed(int value) {
  return value & ColumnMetadata.Indexed == ColumnMetadata.Indexed;
}

bool isUnique(int value) {
  return value & ColumnMetadata.Unique == ColumnMetadata.Unique;
}

bool mustIgnore(int value) {
  return value & ColumnMetadata.Ignore == ColumnMetadata.Ignore;
}
