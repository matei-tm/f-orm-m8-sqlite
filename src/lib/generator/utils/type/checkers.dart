import 'package:f_orm_m8/base/base.dart';
import 'package:f_orm_m8/f_orm_m8.dart';
import 'package:source_gen/source_gen.dart';

final isDbEntity = TypeChecker.fromRuntime(DbEntity);
final isDbAccountRelatedEntity =
    TypeChecker.fromRuntime(DbAccountRelatedEntity);
final isDbAccountEntity = TypeChecker.fromRuntime(DbAccountEntity);

final isDataTable = TypeChecker.fromRuntime(DataTable);
final isDataColumn = TypeChecker.fromRuntime(DataColumn);

final isBool = TypeChecker.fromRuntime(bool);
final isDouble = TypeChecker.fromRuntime(double);
final isInt = TypeChecker.fromRuntime(int);
final isNum = TypeChecker.fromRuntime(num);

final isBigInt = TypeChecker.fromRuntime(BigInt);
final isDateTime = TypeChecker.fromRuntime(DateTime);
final isDuration = TypeChecker.fromRuntime(Duration);
final isString = TypeChecker.fromRuntime(String);

final isList = TypeChecker.fromRuntime(List);
final isMap = TypeChecker.fromRuntime(Map);
