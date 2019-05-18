import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("my_supported_types_table")
class HealthEntry implements DbEntity {
  @DataColumn("my_id_column", metadataLevel: ColumnMetadata.primaryKey)
  int id;

  @DataColumn("my_list_column")
  List<int> listField;

  @DataColumn("my_map_column")
  Map<String, dynamic> mapField;
}
