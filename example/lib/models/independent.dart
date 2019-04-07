import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable(
    "my_health_entries_table",
        TableMetadata.TrackCreate |
        TableMetadata.TrackUpdate)
class HealthEntry implements DbEntity {
  @DataColumn(
      "my_id_column",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int id;

  @DataColumn("my_description_column", ColumnMetadata.Unique)
  String description;

  @DataColumn("my_future_column", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int futureData;
}
