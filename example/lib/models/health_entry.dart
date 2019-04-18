import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable(
    "health_entry", TableMetadata.TrackCreate | TableMetadata.TrackUpdate)
class HealthEntry implements DbAccountRelatedEntity {
  @DataColumn(
      "id",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int id;

  @DataColumn("description", ColumnMetadata.NotNull)
  String description;

  @DataColumn("diagnosys_date")
  DateTime diagnosysDate;

  @override
  @DataColumn("account_id", ColumnMetadata.NotNull)
  int accountId;

  @DataColumn(
      "my_future_column7", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int futureData;
}
