import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable(
    "health_entries", TableMetadata.TrackCreate | TableMetadata.TrackUpdate)
class HealthEntry implements DbEntity {
  @DataColumn(
      "id",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int id;

  @DataColumn("description", ColumnMetadata.Unique)
  String description;

  @DataColumn("diagnosys_date")
  DateTime diagnosysDate;

  @DataColumn(
      "my_future_column3", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int futureData;
}
