import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable(
    "my_health_entries_table",
    TableMetadata.softDeletable |
        TableMetadata.trackCreate |
        TableMetadata.trackUpdate)
class HealthEntry implements DbEntity {
  @DataColumn("my_id_column",
      metadataLevel: ColumnMetadata.primaryKey | ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("my_description_column", metadataLevel: ColumnMetadata.unique)
  String description;

  @DataColumn("my_future_column",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;
}
