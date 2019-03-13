import 'package:analyzer/dart/element/type.dart';
import 'package:flutter_orm_m8/base/base.dart';
import 'package:flutter_orm_m8/flutter_orm_m8.dart';
import 'package:source_gen/source_gen.dart';

final isDbEntity = TypeChecker.fromRuntime(DbEntity);
final isDbAccountRelatedEntity =
    TypeChecker.fromRuntime(DbAccountRelatedEntity);
final isDbAccountEntity = TypeChecker.fromRuntime(DbAccountEntity);

final isDataTable = TypeChecker.fromRuntime(DataTable);
final isDataColumn = TypeChecker.fromRuntime(DataColumn);
final isColumnMetadata = TypeChecker.fromRuntime(ColumnMetadata);

final isBool = TypeChecker.fromRuntime(bool);
final isDouble = TypeChecker.fromRuntime(double);
final isInt = TypeChecker.fromRuntime(int);
final isNum = TypeChecker.fromRuntime(num);

final isDateTime = TypeChecker.fromRuntime(DateTime);
final isString = TypeChecker.fromRuntime(String);
final isList = TypeChecker.fromRuntime(List);
final isMap = TypeChecker.fromRuntime(Map);

bool isNativeType(DartType dartType) {
  if (isBool.isExactlyType(dartType) ||
      isDouble.isExactlyType(dartType) ||
      isInt.isExactlyType(dartType) ||
      isNum.isExactlyType(dartType) ||
      isString.isExactlyType(dartType)) {
    return true;
  }

  return false;
}

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
