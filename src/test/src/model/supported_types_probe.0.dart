import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("my_supported_types_table")
class HealthEntry implements DbEntity {
  @DataColumn("my_id_column", metadataLevel: ColumnMetadata.primaryKey)
  int id;

  @DataColumn("my_bigint_column")
  BigInt bigintField;

  @DataColumn("my_bool_column")
  bool boolField;

  @DataColumn("my_datetime_column")
  DateTime datetimeField;

  @DataColumn("my_double_column")
  double doubleField;

  @DataColumn("my_duration_column")
  Duration durationField;

  @DataColumn("my_num_column")
  num numField;

  @DataColumn("my_string_column")
  String stringField;

  // @DataColumn("my_not_implemented_column")
  // List<String> notImplementedField;
}
